require 'prawn'
require 'open-uri'

class MealPlansController < ApplicationController
  
  def week_overview
    update_meal_plans_of_week
  end
  
  def new
    if params[:date]
      @meal_plan.date = params[:date]
    end
    
    if params[:daytime]
      @meal_plan.daytime = params[:daytime]
    end
  end

  def create
    if current_user.meal_plans << @meal_plan
      redirect_to meal_plans_path
    else
      render action: 'new'
    end
  end

  def destroy
    @meal_plan.destroy
    
    update_meal_plans_of_week
    
    render action: 'week_overview'
  end

  def edit
    
  end
  
  def update
    if @meal_plan.update_attributes(meal_plan_params)
      redirect_to meal_plans_path
    else
      render action: "edit"
    end
  end
  
  def ingredient_requirements
    update_meal_plans_of_week
    
    #    @quantities = @meal_plans.first.quantities
            
    @meal_plans.each do |m|
      @quantities = m.quantities unless @quantities
      @quantities.merge m.quantities
    end
    
    if @quantities
      @quantities = @quantities.group( :unit_id, :ingredient_id ).sum :quantity
    else
      @quantities = {}
    end
    
    @counts = @meal_plans.group( :recipe_id ).count
  end
    
  def ingredient_requirements_pdf
    update_meal_plans_of_week
    
    recipe_ids = @meal_plans.collect &:recipe_id 
    @recipes = Recipe.where ["id in (?)", recipe_ids]

#    @quantities = @meal_plans.first.quantities
        
    @meal_plans.each do |m|
      @quantities = m.quantities unless @quantities
      @quantities.merge m.quantities
    end
    
    @quantities = @quantities.group( :unit_id, :ingredient_id ).sum :quantity
    @counts = @meal_plans.group( :recipe_id ).count
           
    pdf = Prawn::Document.new 
    pdf.define_grid( columns: 6, rows: 10, gutter:10 )
    
    @quantities.each do |key, value|
      q = Quantity.find( key )[0]
      pdf.text "• #{value * @counts[q.recipe_id]}#{q.unit.name} #{q.ingredient.name}"
    end
    
    @recipes.each do |r|
      pdf.start_new_page
      
      pdf.grid([0, 0], [2, 2]).bounding_box do
        picture = r.pictures.first
        if picture  
          path = picture.picture_path 
        else 
          path = "app/assets/images/no_image.png"
        end
        
        pdf.image open( path ), fit: [pdf.bounds.width, pdf.bounds.height]
      end
      
      pdf.grid([0, 3], [2, 5]).bounding_box do
        pdf.text "<u>#{r.name}</u>", size: 16, inline_format: true
        pdf.move_down 5
        
        r.quantities.each do |q|
          pdf.text "#{ q.quantity }#{ q.unit.name } #{ q.ingredient.name }", overflow: :truncate
        end
      end
      
      pdf.grid([3, 0], [9, 5]).bounding_box do
        pdf.move_cursor_to pdf.bounds.top
          
        pdf.span pdf.bounds.width do
          pdf.text r.instructions
        end
      end
    end
    
    content = pdf.render
    
    MealPlanMailer.meal_week_plan( current_user, content ).deliver
    
    send_data content,
        :filename => "#{current_user.name}_shop_list.pdf",
        :type => "application/pdf"
    
#    render action: "ingredient_requirements"
  end
  
  private
    def meal_plan_params
      params.require( 'meal_plan' ).permit(:recipe_id, :date, :daytime)
    end
    
    def update_meal_plans_of_week
      if params[:date]
        d = Date.parse(params[:date])
      else
        d = Date.today
      end
      
      @week_start = d.beginning_of_week
      @week_end = @week_start.end_of_week
      @meal_plans = current_user.meal_plans.where("date <= '#{ @week_end }' and date >= '#{ @week_start }'")
    end
end

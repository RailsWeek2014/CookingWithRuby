require 'prawn'
require 'open-uri'

class MealPlansController < ApplicationController
  before_action :authenticate_user!
  
  def week_overview
    update_meal_plans_of_week
  end
  
  def new
    @meal_plan = MealPlan.new
    
    if params[:date]
      @meal_plan.date = params[:date]
    end
    
    if params[:daytime]
      @meal_plan.daytime = params[:daytime]
    end
  end

  def create
    @meal_plan = MealPlan.new meal_plan_params
    
    if current_user.meal_plans << @meal_plan
      redirect_to meal_plans_path
    else
      render action: 'new'
    end
  end

  def destroy
  end

  def edit
    @meal_plan = MealPlan.find(params[:id])
  end
  
  def update
    @meal_plan = MealPlan.find(params[:id])
          
    if @meal_plan.update_attributes(meal_plan_params)
      redirect_to meal_plans_path
    else
      render action: "edit"
    end
  end
  
  def ingredient_requirements
    update_meal_plans_of_week
    
    #Vorsicht bösartiger Datenbankzugriff voraus
    @quantities = @meal_plans
                          .joins( :recipe )
                          .joins( :quantities )
                          .joins( "inner join ingredients on ingredients.id = quantities.ingredient_id" )
                          .joins( "inner join units on units.id = quantities.unit_id" )
                          .group( "ingredients.name", "quantities.unit_id" )
                          .pluck( "sum( quantity )", :short_name, "ingredients.name" )
  
#    recipe_ids = @meal_plans.collect &:recipe_id 
#    @recipes = Recipe.where ["id in (?)", recipe_ids]
#    @quantities = Quantity.where ["recipe_id in (?)", recipe_ids]
    
#    <% @quantities.group(:ingredient_id, :unit_id).pluck("sum(quantity)", :unit_id, :ingredient_id).each do |q|%>
#      <p><%= "#{q[0]}#{Unit.find( q[1] ).short_name} #{Ingredient.find( q[2] ).name}" %></p>
#    <% end %>
                        
#    @recipes = Recipe.all.where "id in( #{ @meal_plans.collect do |m| m.recipe_id end } )"
#    @quantities = @meal_plans.joins( :recipe ).joins( :quantities ).group( :ingredient_id ).sum( :quantity )
  end
    
  def ingredient_requirements_pdf
    update_meal_plans_of_week
    
    recipe_ids = @meal_plans.collect &:recipe_id 
    @recipes = Recipe.where ["id in (?)", recipe_ids]
      
    #Vorsicht bösartiger Datenbankzugriff voraus
    @quantities = @meal_plans
                          .joins( :recipe )
                          .joins( :quantities )
                          .joins( "inner join ingredients on ingredients.id = quantities.ingredient_id" )
                          .joins( "inner join units on units.id = quantities.unit_id" )
                          .group( "ingredients.name", "quantities.unit_id" )
                          .pluck( "sum( quantity )", :short_name, "ingredients.name" )
    
    pdf = Prawn::Document.new 
    pdf.define_grid( columns: 6, rows: 10, gutter:10 )
    
    @quantities.each do |q|
      pdf.text "• #{q.join " "}"
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
        r.quantities.each do |q|
          pdf.text "#{ q.quantity }#{ q.unit.short_name } #{ q.ingredient.name }", overflow: :truncate
        end
      end
      
      pdf.grid([3, 0], [9, 5]).bounding_box do
        pdf.move_cursor_to pdf.bounds.top
          
        pdf.span pdf.bounds.width do
          pdf.text r.instructions
        end
      end
    end
    
    send_data pdf.render,
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

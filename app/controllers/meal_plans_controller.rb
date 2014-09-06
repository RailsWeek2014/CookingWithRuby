class MealPlansController < ApplicationController
  before_action :authenticate_user!
  
  def week_overview
    if params[:date]
      d = Date.parse(params[:date])
    else
      d = Date.today
    end
    
    @week_start = d.beginning_of_week
    @week_end = @week_start.end_of_week
    @meal_plans = current_user.meal_plans.where("date <= '#{ @week_end }' and date >= '#{ @week_start }'")
  end
  
  def new
    @meal_plan = MealPlan.new
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
  
  private
    def meal_plan_params
      params.require( 'meal_plan' ).permit(:recipe_id, :date, :daytime)
    end
end

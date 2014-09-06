class MealPlansController < ApplicationController
  before_action :authenticate_user!
  
  def list
    
  end

  def new
    @meal_plan = MealPlan.new
  end

  def create
    @meal_plan = MealPlan.new meal_plan_params
    
    if @meal_plan.date.future?
      current_user.meal_plans << @meal_plan
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

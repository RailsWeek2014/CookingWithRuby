class IngredientsController < ApplicationController
  def new
    unless current_user
      redirect_to new_user_session_path
    end
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new recipe_params
    
    if @ingredient.save
      current_user.ingredients << @ingredient
      redirect_to recipes_path
    else
      render action: 'new'
    end
  end
end

class IngredientsController < ApplicationController
  def new
    unless current_user
      redirect_to new_user_session_path
    end
    @ingredient = Ingredient.new
  end

  def create
    @ingredient = Ingredient.new ingredient_params
    
    if @ingredient.save
      redirect_to recipes_path
    else
      render action: 'new'
    end
  end
  
  
  private
    def ingredient_params
      params.require( 'ingredient' ).permit( 'name', 'kj', 'corbohydrate', 'protein', 'fat', 'roughage', 'default_quantity', 'unit_id')
    end
end

class IngredientsController < ApplicationController
  def new
    
  end

  def create
    if @ingredient.save
      redirect_to recipes_path
    else
      render action: 'new'
    end
  end
  
  
  private
    def ingredient_params
      params.require( 'ingredient' ).permit( 'name', 'kj', 'carbohydrate', 'protein', 'fat', 'roughage', 'default_quantity', 'unit_id')
    end
end

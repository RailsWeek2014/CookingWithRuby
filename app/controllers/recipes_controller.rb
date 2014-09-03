class RecipesController < ApplicationController
  def recipes
    @recipes = Recipe.all
  end
  
  def new
    @recipe = Recipe.new
  end
  
  def create
    @recipe = Recipe.new recipe_params
    
    if @recipe.save
      redirect_to recipes_path
    else
      render action: 'new'
    end
  end
  
  private
    def recipe_params
      params.require( 'recipe' ).permit( 'name', 'prep_time')
    end
end

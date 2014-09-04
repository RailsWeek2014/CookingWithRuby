class RecipesController < ApplicationController
  def list
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
  
  def update
    @recipe = Recipe.find(params[:id])
      
    if @recipe.update_attributes(recipe_params)
      redirect_to recipes_path
    else
      render action: "edit"
    end
  end
  
  def delete
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
    
  private
    def recipe_params
      params.require( 'recipe' ).permit( 'name', 'instructions', 'prep_time', 'range')
    end
end

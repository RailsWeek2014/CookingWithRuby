class RecipesController < ApplicationController
  def index
    redirect_to recipes_list_path
  end
  
  def list
    unless current_user
      @recipes = Recipe.where(:range ["public"])
    else
      @recipes = Recipe.where("range in ('registrated', 'public') or user_id = #{ current_user.id }")
    end
    @recipes = Recipe.all
  end
  
  def specific_list
    @user = User.find(params[:id])
    unless current_user
      @recipes = @user.recipes.where(range: ["public"])
    else
      unless current_user.id.to_s == params[:id]
        @recipes = @user.recipes.where(range: ["public", "registrated"])
      else
         @recipes = @user.recipes.all
      end 
    end    
  end
  
  def new
    unless current_user
      redirect_to new_user_session_path
    end
    @recipe = Recipe.new
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def create
    @recipe = Recipe.new recipe_params
    
    if @recipe.save
      current_user.recipes << @recipe
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
  
  def destroy
    @recipe = Recipe.find(params[:id])
    @recipe.destroy
    redirect_to recipes_url
  end
  
  def edit
    @recipe = Recipe.find(params[:id])
  end
    
  private
    def recipe_params
      params.require( 'recipe' ).permit( 'name', 'instructions', 'prep_time', 'range')
    end
end

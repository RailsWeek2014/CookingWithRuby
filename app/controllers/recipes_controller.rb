class RecipesController < ApplicationController
  def index
    redirect_to recipes_list_path
  end
  
  def list
    unless user_signed_in?
      @recipes = Recipe.where(range: ["public"])
    else
      @recipes = Recipe.where("range in ('registrated', 'public') or user_id = '#{ current_user.id }'")
    end
  end
  
  def specific_list
    @user = User.find(params[:id])
    where = {range: ["public"]}
    
    if user_signed_in?
      unless current_user.id.to_s == params[:id]
      where = {range: ["public", "registrated"]}
      else
      where = {range: ["public", "registrated", "private"]}
      end 
    end
    @recipes = @user.recipes.where(where)    
  end
  
  def new
    unless user_signed_in?
      redirect_to new_user_session_path
    end
    @recipe = Recipe.new
    @recipe.quantities.build
    @recipe.quantities.first.build_unit
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
      params.require( 'recipe' ).permit( 'name', 'instructions', 'prep_time', 'range', 
        quantities_attributes: [:id, :quantity, 
          :unit_id,
          :ingredient_id
        ]
      )
    end
end

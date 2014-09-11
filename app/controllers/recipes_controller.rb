class RecipesController < ApplicationController
  def index
    redirect_to recipes_list_path
  end
  
  def list
  end
  
  def specific_list
    @user = User.find(params[:user_id])
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
    @recipe.quantities.build
    @recipe.quantities.first.build_unit
    @recipe.categories.build
  end
  
  def show
  end
  
  def create
    unless params[:recipe][:category_ids].nil?
      params[:recipe][:category_ids].uniq!
    end
    
    if @recipe.save
      current_user.recipes << @recipe
      redirect_to recipes_path
    else
      render action: 'new'
    end
  end
  
  def update
    unless params[:recipe][:category_ids].nil?
      params[:recipe][:category_ids].uniq!
    end
    if @recipe.update_attributes(recipe_params)
      redirect_to recipes_path
    else
      render action: "edit"
    end
  end
  
  def destroy
    @recipe.destroy
   
    redirect_to recipes_url
  end
  
  def rate    
    @rating = Rating.find_or_initialize_by(user: current_user, recipe_id: params[:id])
    @rating.rating = params[:rating]
    if(@rating.save) 
      render text: "ok"
    else
      render text: "nok"
    end
  end
  
  def edit
#    @recipe = Recipe.find(params[:id])
  end
    
  private
    def recipe_params
      params.require( 'recipe' ).permit( 'name', 'instructions', 'prep_time', 'range', 'number_of_portions',
        category_ids: [],
        quantities_attributes: [:id, :quantity, 
          :unit_id,
          :ingredient_id,
          :_destroy
        ]
      )
    end
end

class CategoriesController < ApplicationController
  def new
    unless current_user
      redirect_to new_user_session_path
    end
    @category = Category.new
  end
    
  def create
    @category = Category.new category_params
    
    if @category.save
      redirect_to recipes_path
    else
      render action: 'new'
    end
  end
  
  private
    def category_params
      params.require( 'category' ).permit( 'name')
    end
end
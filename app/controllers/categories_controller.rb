class CategoriesController < ApplicationController
  def new
#    @category = Category.new
  end
    
  def create
    respond_to do |format|      
      if @category.save
        format.html { 
          redirect_to @user, notice: 'User was successfully created.' 
        }
        format.js {
          @categories = Category.all.select(:id, :name).to_json.html_safe
        }
      else
        render action: 'new'
      end
    end
  end
  
  private
    def category_params
      params.require( 'category' ).permit( 'name')
    end
end
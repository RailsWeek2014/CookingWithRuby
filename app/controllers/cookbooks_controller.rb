class CookbooksController < ApplicationController
  
  def list
    @cookbooks = Cookbook.where("user_id = '#{ current_user.id }'")
  end
    
  def show
    @cookbook = Cookbook.find(params[:id])
    @cookbook_entries = @cookbook.cookbook_entries
    @recipes = @cookbook_entries.collect &:recipe    
  end
  
  def new
    @cookbook = Cookbook.new
    render "edit", layout: false
  end
    
  def create
    @cookbook = Cookbook.new cookbook_params
    @cookbook.user_id = current_user.id
    if @cookbook.save
      redirect_to cookbook_list_path
    else
      render text: "nok"
    end
  end
  
  def edit
    @cookbook = Cookbook.find(params[:id])
    render layout: false
  end
  
  def update
    @cookbook = Cookbook.find(params[:id])
    if @cookbook.update_attributes(cookbook_params)
      redirect_to cookbook_list_path
    else
      redirect_to cookbook_list_path
    end
  end
  
  def destroy
    @cookbook = Cookbook.find(params[:id])
    @cookbook.destroy
    redirect_to cookbook_list_path
  end
  
  private
    def cookbook_params
      params.require( 'cookbook' ).permit( 'name')
    end
end
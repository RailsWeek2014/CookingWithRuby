class CookbooksController < ApplicationController
  
  def list
    unless user_signed_in?
      redirect_to new_user_session_path
    else
      @cookbooks = Cookbook.where("user_id = '#{ current_user.id }'")
    end
  end
    
  def new
    unless current_user
      redirect_to new_user_session_path
    end
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
  
  def add
    unless current_user
      redirect_to new_user_session_path
    end
    @cookbook_entry = Cookbook_Entry.new
    
    @cookbook_entry.cookbooks  << Cookbook.new
  end
  
  def destroy
    unless user_signed_in?
      redirect_to new_user_session_path
    else
      @cookbook = Cookbook.find(params[:id])
      @cookbook.destroy
      redirect_to cookbook_list_path
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
  
  private
    def cookbook_params
      params.require( 'cookbook' ).permit( 'name')
    end
end
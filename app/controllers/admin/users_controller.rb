class Admin::UsersController < ApplicationController
  skip_load_and_authorize_resource
  before_action :is_user_admin?
  
  def list
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    role = params[:role]
    if(['u', 'm', 'a']).include? role
      @user.role = role
      if @user.save
        @current_ability = nil
        @current_user = nil
      end
      redirect_to admin_users_path
    end
  end

  def delete
  end
  
  private 
    def is_user_admin?
      redirect_to root_url, notice: "You don't have permission for that" unless can? :grant_permissions, User
    end
end

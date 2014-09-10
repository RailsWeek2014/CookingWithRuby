class Admin::UsersController < ApplicationController
  def list
    @users = User.all
  end

  def update
    @user = find(params[:id])
    role = params[:role]
    if(['u', 'm', 'a']).include? role
      @user.role = role
      @user.save
      redirect_to admin_users_path
    end
  end

  def delete
  end
end

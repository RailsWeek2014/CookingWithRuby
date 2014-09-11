class Users::RegistrationsController < Devise::RegistrationsController
  def update
   
    @user = User.find(current_user.id)

    if @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
    #if @user.update_attributes(account_update_params)
      set_flash_message :notice, :updated
      # Sign in the user bypassing validation in case their password changed
      sign_in @user, :bypass => true
      @current_ability = nil
      @current_user = nil
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end
end
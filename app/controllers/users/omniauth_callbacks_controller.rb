class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def github
    auth = request.env["omniauth.auth"]
    auth.extra = nil
    @user = User.from_omniauth(auth)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "GitHub") if is_navigational_format?
    else
      session["devise.auth_data"] = auth 
      redirect_to new_user_registration_url
    end
  end
end
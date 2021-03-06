class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  
  def github
    auth = request.env["omniauth.auth"]
    omniauth(auth, "GitHub")
  end

  def twitter
    auth = request.env["omniauth.auth"]
    omniauth(auth, "Twitter")
  end
  
  def google_oauth2
    auth = request.env["omniauth.auth"]
    auth.info.image = auth.info.image.gsub /50$/, '150'
    omniauth(auth, "Google")
  end
  
  private 
    def omniauth(auth, provider)
      if auth.info.name.nil?
        auth.info.name = auth.info.nickname
      end

      @user = User.from_omniauth(auth, current_user) 
      if @user.persisted?
        sign_in_and_redirect @user, event: :authentication #this will throw if @user is not activated
        set_flash_message(:notice, :success, :kind => provider) if is_navigational_format?
      else
        session["devise.auth_data"] = auth 
        redirect_to new_user_registration_url
      end        
    end
end
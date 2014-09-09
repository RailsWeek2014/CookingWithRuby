class Users::RegistrationsController < Devise::RegistrationsController
  def new
    if session["devise.auth_data"]
      @user = User.register_omniauth(session["devise.auth_data"])
    else
      @user = User.new
    end
  end

  def create
    super
  end
  
  def update
    super
  end
  
  protected
    def sign_up_params
      params.require( :user ).permit( :email, :password, :password_confirmation, 
          :name, :username, :birth_date, :sex, :weight, :picture )
    end
    
    def account_update_params
      params.require( :user ).permit( :email, :password, :password_confirmation, 
          :name, :username, :birth_date, :sex, :weight, :picture )
    end
end
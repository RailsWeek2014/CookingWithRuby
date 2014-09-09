class Users::RegistrationsController < Devise::RegistrationsController
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
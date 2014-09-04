class Users::RegistrationsController < Devise::RegistrationsController
  def create
    super
  end
  
  def update
    super
  end
  
  protected
    def sign_up_params
      params.require( :user ).permit( :email, :password, :password_confirmation, 
          :name, :birth_date, :sex, :weight )
    end
    
    def account_update_params
      params.require( :user ).permit( :email, :password, :password_confirmation, 
          :name, :birth_date, :sex, :weight, :picture )
    end
end
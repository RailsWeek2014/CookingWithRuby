class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?

  before_action :set_locale
  load_and_authorize_resource unless: :devise_controller?
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    unless(cookies[:lang].nil? || cookies[:lang].length != 2)
      I18n.locale = cookies[:lang]
    else
      begin
        I18n.locale = extract_locale_from_accept_language_header
      rescue I18n::InvalidLocale => e
        I18n.locale = I18n.default_locale
      end
    end
      
    logger.debug "* Locale set to '#{I18n.locale}'"
  end
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) do |u|
        u.permit(:email, :password, :password_confirmation, 
          :name, :username, :birth_date, :sex, :weight, :height)
      end
      devise_parameter_sanitizer.for(:account_update) do |u|
        u.permit(:email, :password, :password_confirmation, 
          :name, :username, :birth_date, :sex, :weight, :height, :picture)
      end
    end
  
  private
    def extract_locale_from_accept_language_header
      request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    end
    
end

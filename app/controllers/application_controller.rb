class ApplicationController < ActionController::Base
  before_action :config_permitted_params, if: :devise_controller?

  protected
    def config_permitted_params
      devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :email, :phone, :address, :password] )
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :email, :phone, :address, :password, :current_password, :password_confirmation])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password] )
    end
end

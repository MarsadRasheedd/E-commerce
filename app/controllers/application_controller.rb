# frozen_string_literal: true

# this controller handles over-all application methods.
class ApplicationController < ActionController::Base
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  before_action :config_permitted_params, if: :devise_controller?

  def pundit_user?
    user_signed_in?
  end

  private

  def record_not_found
    flash[:alert] = 'Request is in-valid.'
    redirect_back(fallback_location: root_path)
  end

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end

  protected

  def config_permitted_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name email phone cartt_id address password role])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name email phone address role
                                                                current_password])
    devise_parameter_sanitizer.permit(:sign_in, keys: %i[email password])
  end
end

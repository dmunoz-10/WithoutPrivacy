# frozen_string_literal: true

# Application Controller
class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protect_from_forgery

  def content_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: %i[first_name last_name username
                                               avatar description gender birth_date])
    devise_parameter_sanitizer.permit(:account_update,
                                      keys: %i[first_name last_name username
                                               avatar description gender birth_date])
  end
end

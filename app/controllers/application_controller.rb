class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  GUEST_EMAIL = "guest@example.com".freeze

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name]
  end
end

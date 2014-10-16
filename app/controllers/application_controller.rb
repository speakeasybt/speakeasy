class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  def check_staff_authorization
    if !current_user.is_staff?
      redirect_to root_url, :alert => "You are not authorized to do that!"
    end
  end

  def peek_enabled?
    current_user.is_staff?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation) }
  end
end

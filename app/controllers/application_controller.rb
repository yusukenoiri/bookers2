class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # protectedは呼び出された他のコントローラからも参照できる

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
  end
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:name,:email])
  end
end

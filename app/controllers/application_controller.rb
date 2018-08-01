class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken
  include ExceptionHandler
  include NotificationManager

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name nickname image])
  end
end

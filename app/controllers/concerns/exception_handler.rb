module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do
      json_response({ message: I18n.t('api.errors.not_found') }, :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response({ message: e.message }, :unprocessable_entity)
    end

    rescue_from ActionController::ParameterMissing do
      json_response(
        { message: I18n.t('api.errors.missing_param') },
        :unprocessable_entity
      )
    end
  end
end

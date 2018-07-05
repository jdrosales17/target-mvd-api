module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      before_action :set_user_by_token, only: [:destroy]
      after_action :reset_session, only: [:destroy]

      def facebook
        user_params = FacebookService.new(params[:access_token]).profile
        if user_params && user_params['id'] == params[:uid]
          @resource = User.from_provider('facebook', user_params)
          sign_in(:user, @resource)
          new_auth_header = @resource.create_new_auth_token
          response.headers.merge!(new_auth_header)
          render_create_success
        else
          render json: { error: 'Not Authorized.' }, status: :forbidden
        end
      rescue Koala::Facebook::AuthenticationError
        render json: { error: 'Not Authorized.' }, status: :forbidden
      rescue ActiveRecord::RecordNotUnique
        render json: { error: 'User already registered with email/password.' }, status: :bad_request
      end
    end
  end
end

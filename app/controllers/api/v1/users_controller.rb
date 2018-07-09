module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      def update
        current_user.update!(user_params)
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:latitude, :longitude)
      end
    end
  end
end

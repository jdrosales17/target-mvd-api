module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_user!

      # PUT /api/v1/users/me
      def update
        current_user.update!(user_params)
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:name, :nickname, :image, :latitude, :longitude)
      end
    end
  end
end

module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_user!

      def index
        @targets = Target.where(user_id: current_user.id)
      end

      def create
        @target = Target.create!(target_params.merge(user_id: current_user.id))
      end

      private

      def target_params
        params.require(:target).permit(:title, :area_length, :topic_id, :latitude, :longitude)
      end
    end
  end
end

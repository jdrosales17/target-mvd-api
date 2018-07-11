module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_user!
      
      def create
        @target = Target.create!(target_params)
      end

      private

      def target_params
        params.require(:target).permit(:title, :area_length, :topic_id, :latitude, :longitude)
      end
    end
  end
end

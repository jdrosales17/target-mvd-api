module Api
  module V1
    class TargetsController < ApplicationController
      before_action :authenticate_user!

      # GET /api/v1/targets
      def index
        @targets = current_user.targets
      end

      # POST /api/v1/targets
      def create
        @target = current_user.targets.create!(target_params)
        Target.search_compatible_targets(@target)
      end

      # DELETE /api/v1/targets/:id
      def destroy
        target.destroy
        head :no_content
      end

      private

      def target_params
        params.require(:target)
              .permit(:title, :area_length, :topic_id, :latitude, :longitude)
      end

      def target
        @target ||= current_user.targets.find(params[:id])
      end
    end
  end
end

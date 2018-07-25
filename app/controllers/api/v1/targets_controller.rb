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
        @compatible_users = @target.search_compatible_targets.map do |target|
          compatible_user = target.user
          begin
            notify(
              compatible_user.devices.map(&:device_id),
              I18n.t('api.notifications.titles.new_compatible_target'),
              I18n.t('api.notifications.messages.new_compatible_target')
            )
          rescue RuntimeError => e
            logger.error e
          end
          compatible_user
        end
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

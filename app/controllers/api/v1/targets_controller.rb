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
        @compatible_users = []
        @target.search_compatible_targets.each do |compatible_target|
          @compatible_users.push(compatible_target.user)
          begin
            notify(compatible_target.user.devices.map(&:device_id))
          rescue RuntimeError => e
            logger.error e
          end
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

      def notify(device_ids)
        OneSignalService.new.send_notification(
          device_ids,
          I18n.t('api.notifications.titles.new_compatible_target'),
          I18n.t('api.notifications.messages.new_compatible_target')
        )
      end
    end
  end
end

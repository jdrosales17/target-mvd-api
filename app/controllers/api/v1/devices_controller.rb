module Api
  module V1
    class DevicesController < ApplicationController
      # POST /api/v1/devices
      def create
        @device = current_user.devices.create!(device_params)
      end

      private

      def device_params
        params.require(:device).permit(:device_id)
      end
    end
  end
end

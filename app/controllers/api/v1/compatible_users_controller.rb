module Api
  module V1
    class CompatibleUsersController < ApplicationController
      before_action :authenticate_user!

      # GET /api/v1/compatible_users
      def index
        @compatible_users = []
        current_user.targets.find_each do |target|
          target.search_compatible_targets.each do |compatible_target|
            unless @compatible_users.include?(compatible_target.user)
              @compatible_users.push(compatible_target.user)
            end
          end
        end
      end
    end
  end
end

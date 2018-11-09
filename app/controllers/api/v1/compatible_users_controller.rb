module Api
  module V1
    class CompatibleUsersController < ApplicationController
      before_action :authenticate_user!

      # GET /api/v1/compatible_users
      def index
        @compatible_users = []
        current_user.targets.find_each do |target|
          target.search_compatible_targets.each do |compatible_target|
            @compatible_users |= [compatible_target.user]
          end
        end
      end
    end
  end
end

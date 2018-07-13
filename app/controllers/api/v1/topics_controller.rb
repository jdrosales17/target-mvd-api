module Api
  module V1
    class TopicsController < ApplicationController
      before_action :authenticate_user!
      
      # GET /api/v1/topics
      def index
        @topics = Topic.all
      end
    end
  end
end

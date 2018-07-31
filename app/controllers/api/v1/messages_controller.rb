module Api
  module V1
    class MessagesController < ApplicationController
      before_action :authenticate_user!

      # GET /api/v1/conversations/:conversation_id/messages
      def index
        @messages = conversation.messages
      end

      private

      def conversation
        @conversation ||= current_user.conversations.find(
          params[:conversation_id]
        )
      end
    end
  end
end

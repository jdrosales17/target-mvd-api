module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :authenticate_user!

      # POST /api/v1/questions
      def create
        if params.has_key?(:subject) && params.has_key?(:body)
          ApplicationMailer.email_to_admin(current_user.email, params[:subject], params[:body]).deliver_now
          head :no_content
        else
          raise ActionController::ParameterMissing.new('subject/body')
        end
      end
    end
  end
end

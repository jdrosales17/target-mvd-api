module Api
  module V1
    class QuestionsController < ApplicationController
      before_action :authenticate_user!

      # POST /api/v1/questions
      def create
        ApplicationMailer.email_to_admin(current_user.email, question_params).deliver_now
        head :no_content
      end

      private

      def question_params
        params.require(:email).permit(:subject, :body)
      end
    end
  end
end

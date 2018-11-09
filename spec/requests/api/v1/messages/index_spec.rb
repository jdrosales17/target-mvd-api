require 'rails_helper'

# Test suite for GET /api/v1/conversations/:conversation_id/messages
describe 'GET /api/v1/conversations/:conversation_id/messages', type: :request do
  let(:user)         { create(:user) }
  let(:conversation) { create(:conversation_with_users_and_msgs, user_1: user) }

  before(:each) { user.confirm }

  context 'when the request is valid' do
    before do
      get "/api/v1/conversations/#{conversation.id}/messages",
          headers: auth_headers(user)
    end

    it 'returns all the conversation messages' do
      expect(json).not_to be_empty
      expect(json['messages'].size).to eq(conversation.messages.size)
      expect(json['messages'].map { |message| message['id'] })
        .to match_array(conversation.messages.pluck(:id))
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end

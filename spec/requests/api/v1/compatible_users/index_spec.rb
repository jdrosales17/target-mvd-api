require 'rails_helper'

# Test suite for GET /api/v1/compatible_users
describe 'GET /api/v1/compatible_users', type: :request do
  let(:user)        { create(:user) }
  let(:other_user)  { create(:user) }

  before(:each) do
    user.confirm
    target = create(:target, user_id: user.id)
    create_list(
      :target, 2,
      topic_id: target.topic.id,
      user_id: other_user.id,
      latitude: target.latitude,
      longitude: target.longitude
    )
    conversation = create(:conversation, users: [user, other_user])
    create(:message, sender: other_user, conversation: conversation)
  end

  context 'when the request is valid' do
    before { get '/api/v1/compatible_users', headers: auth_headers(user) }

    it 'returns all compatible users' do
      expect(json).not_to be_empty
      expect(json['compatible_users'].size).to eq(1)
      expect(json['compatible_users'][0]['id']).to eq(other_user.id)
      expect(json['compatible_users'][0]['name']).to eq(other_user.name)
      expect(json['compatible_users'][0]['image']['url'])
        .to eq(other_user.image.url)
      expect(json['compatible_users'][0]['room_id'])
        .to eq(user.conversation_with(other_user).id)
      expect(json['compatible_users'][0]['unread_messages'])
        .to eq(user.unread_messages_with(other_user))
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end

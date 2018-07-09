require 'rails_helper'

# Test suite for PUT /api/v1/user/:id
describe 'PUT /api/v1/user/:id', type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let(:headers) { user.create_new_auth_token }
  let(:payload) { { user: random_location } }

  before(:each) do
    user.confirm
  end

  context 'when the request is valid' do
    before { put '/api/v1/users/me', params: payload, headers: headers }

    it 'changes the attributes of the user sending the request with code 204' do
      updated_user = User.find(user.id)
      expect(updated_user[:latitude]).to match(payload[:user][:latitude])
      expect(updated_user[:longitude]).to match(payload[:user][:longitude])
      expect(response).to have_http_status(204)
    end
  end

  context 'when trying to update another user' do
    before { put "/api/v1/users/#{user2[:id]}", params: payload, headers: headers }

    it 'does not change the attributes of user2 with code 204' do
      target_user = User.find(user2.id)
      expect(target_user[:latitude]).not_to match(payload[:user][:latitude])
      expect(target_user[:longitude]).not_to match(payload[:user][:longitude])
      expect(response).to have_http_status(204)
    end

    it 'changes the attributes of the user sending the request with code 204' do
      updated_user = User.find(user.id)
      expect(updated_user[:latitude]).to match(payload[:user][:latitude])
      expect(updated_user[:longitude]).to match(payload[:user][:longitude])
      expect(response).to have_http_status(204)
    end
  end

  context 'when the access token is not valid' do
    before do
      headers['access-token'] = 'invalid_token'
      put '/api/v1/users/me', params: payload, headers: headers
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end

    it 'returns an authorization error message' do
      expect(json['errors'][0])
        .to match('You need to sign in or sign up before continuing.')
    end
  end
end

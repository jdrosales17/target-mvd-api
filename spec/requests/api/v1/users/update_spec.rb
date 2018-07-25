require 'rails_helper'

# Test suite for PUT /api/v1/user/:id
describe 'PUT /api/v1/user/:id', type: :request do
  let(:user)       { create(:user) }
  let(:other_user) { create(:user) }
  let(:payload) do
    {
      user: attributes_for(:user)
        .except(:email, :password).merge(random_location)
    }
  end

  before(:each) { user.confirm }

  context 'when the request is valid' do
    before do
      put '/api/v1/users/me', params: payload, headers: auth_headers(user)
    end

    it 'changes the attributes of the user sending the request' do
      updated_user = User.find(user.id)
      expect(updated_user[:name]).to match(payload[:user][:name])
      expect(updated_user[:nickname]).to match(payload[:user][:nickname])
      expect(updated_user[:latitude]).to match(payload[:user][:latitude])
      expect(updated_user[:longitude]).to match(payload[:user][:longitude])
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'when trying to update another user' do
    before do
      put "/api/v1/users/#{other_user[:id]}",
          params: payload,
          headers: auth_headers(user)
    end

    it 'does not change the attributes of another user' do
      target_user = User.find(other_user.id)
      expect(target_user[:name]).not_to match(payload[:user][:name])
      expect(target_user[:nickname]).not_to match(payload[:user][:nickname])
      expect(target_user[:latitude]).not_to match(payload[:user][:latitude])
      expect(target_user[:longitude]).not_to match(payload[:user][:longitude])
    end

    it 'changes the attributes of the user sending the request' do
      updated_user = User.find(user.id)
      expect(updated_user[:name]).to match(payload[:user][:name])
      expect(updated_user[:nickname]).to match(payload[:user][:nickname])
      expect(updated_user[:latitude]).to match(payload[:user][:latitude])
      expect(updated_user[:longitude]).to match(payload[:user][:longitude])
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'when the access token is not valid' do
    before do
      headers = auth_headers(user)
      headers['access-token'] = 'invalid_token'
      put '/api/v1/users/me', params: payload, headers: headers
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns an authorization error message' do
      expect(json['errors'][0])
        .to match('You need to sign in or sign up before continuing.')
    end
  end
end

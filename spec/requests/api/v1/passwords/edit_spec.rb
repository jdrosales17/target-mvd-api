require 'rails_helper'

# Test suite for POST /api/v1/auth/password/edit
describe 'POST /api/v1/auth/password/edit', type: :request do
  let(:user) { create(:user) }

  before(:each) do
    user.confirm
  end

  context 'when the request is valid' do
    before do
      get '/api/v1/auth/password/edit',
          params: {
            reset_password_token: user.send_reset_password_instructions,
            redirect_url: Faker::Internet.url
          }
    end

    it 'returns status code 302' do
      expect(response).to have_http_status(:found)
    end

    it 'the URL has an access token, a client and an uid in the params' do
      expect(response.headers['Location']).to include('access-token=')
      expect(response.headers['Location']).to include('client=')
      expect(response.headers['Location']).to include('uid=')
    end
  end
end

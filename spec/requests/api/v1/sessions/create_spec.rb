require 'rails_helper'

# Test suite for POST /api/v1/auth/sign_in
describe 'POST /api/v1/auth/sign_in', type: :request do
  let!(:user)        { create(:user) }
  let(:valid_params) { { email: user.email, password: user.password } }

  context 'when the user is confirmed and the credentials are valid' do
    before do
      user.confirm
      post '/api/v1/auth/sign_in', params: valid_params
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'returns access token in the response headers' do
      expect(response.headers['access-token']).not_to be_empty
    end
  end

  context 'when the user is confirmed and the email is wrong' do
    before do
      user.confirm
      post '/api/v1/auth/sign_in', params: { email: 'test@rootstrap.com', password: user.password }
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns a invalid credentials error message' do
      expect(json['errors'][0])
        .to match('Invalid login credentials. Please try again.')
    end
  end

  context 'when the user is confirmed and the password is wrong' do
    before do
      user.confirm
      post '/api/v1/auth/sign_in', params: { email: user.email, password: '1234' }
    end

    it 'returns status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns a invalid credentials error message' do
      expect(json['errors'][0])
        .to match('Invalid login credentials. Please try again.')
    end
  end

  context 'when the user is not confirmed and the credentials are valid' do
    before { post '/api/v1/auth/sign_in', params: valid_params }

    it 'returns status code 401' do
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns a confirmation error message' do
      expect(json['errors'][0])
        .to match("A confirmation email was sent to your account at '#{user.email}'. " \
          'You must follow the instructions in the email before your account can be activated')
    end
  end
end

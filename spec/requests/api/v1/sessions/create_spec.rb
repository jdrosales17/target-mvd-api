require 'rails_helper'

# Test suite for POST /api/v1/auth/sign_in
describe 'POST /api/v1/auth/sign_in', type: :request do
  let!(:user) { create(:user) }
  let(:valid_params) { { email: user.email, password: user.password } }

  context 'when the user is confirmed' do
    before do
      user.confirm
      post '/api/v1/auth/sign_in', params: valid_params
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when the user is not confirmed' do
    before { post '/api/v1/auth/sign_in', params: valid_params }

    it 'returns status code 401' do
      expect(response).to have_http_status(401)
    end

    it 'returns a confirmation error message' do
      expect(json['errors'][0])
        .to match("A confirmation email was sent to your account at '#{user.email}'. " \
          'You must follow the instructions in the email before your account can be activated')
    end
  end
end

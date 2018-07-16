require 'rails_helper'

# Test suite for POST /api/v1/questions
describe 'POST /api/v1/questions', type: :request do
  let(:user)         { create(:user) }
  let(:valid_params) { random_email }

  before(:each) { user.confirm }

  context 'when the request is valid' do
    before do
      post  '/api/v1/questions',
            params: valid_params,
            headers: auth_headers(user)
    end

    it 'returns status code 204' do
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'when the request is invalid' do
    before do
      invalid_params = valid_params.except(:body)
      post  '/api/v1/questions',
            params: invalid_params,
            headers: auth_headers(user)
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a missing parameter error message' do
      expect(json['message'])
        .to match(I18n.t('api.errors.missing_param'))
    end
  end
end

require 'rails_helper'

# Test suite for POST /api/v1/auth/facebook
describe 'POST /api/v1/auth/facebook', type: :request do

  context 'when the request is valid' do
    before do 
      post '/api/v1/auth/facebook',
        params: {
          access_token: '1234',
          uid: '1234'
        }
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns access token in the response headers' do
      expect(response.headers['access-token']).not_to be_empty
    end
  end

  context 'when the request has an invalid uid' do
    before do 
      post '/api/v1/auth/facebook',
        params: {
          access_token: '1234',
          uid: '12'
        }
    end

    it 'returns status code 403' do
      expect(response).to have_http_status(403)
    end
    
    it 'returns a not authorized error message' do
      expect(json['error'])
        .to match('Not Authorized.')
    end
  end
end

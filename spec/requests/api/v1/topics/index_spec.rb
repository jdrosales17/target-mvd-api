require 'rails_helper'

# Test suite for GET /api/v1/topics
describe 'GET /api/v1/topics', type: :request do
  let(:user) { create(:user) }
  let!(:topics) { create_list(:topic, 5) }

  before(:each) do
    user.confirm
  end

  context 'when the request is valid' do
    before { get '/api/v1/topics', headers: auth_headers(user) }

    it 'returns all topics' do
      expect(json).not_to be_empty
      expect(json['topics'].size).to eq(5)
      expect(topics.pluck(:id)).to match_array(json['topics'].map { |topic| topic['id'] })
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end
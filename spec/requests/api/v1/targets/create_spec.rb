require 'rails_helper'

# Test suite for POST /api/v1/targets
describe 'POST /api/v1/targets', type: :request do
  let(:user) { create(:user) }
  let(:topic) { create(:topic) }
  let(:payload) { { target: attributes_for(:target, topic_id: topic.id) } }

  before(:each) do
    user.confirm
  end

  context 'when the request is valid' do
    before { post '/api/v1/targets', params: payload, headers: auth_headers(user) }

    it 'creates a target' do
      expect(json).not_to be_empty
      expect(json['title']).to eq(payload[:target][:title])
      expect(json['area_length']).to eq(payload[:target][:area_length])
      expect(json['topic_id']).to eq(payload[:target][:topic_id])
      expect(json['latitude']).to eq(payload[:target][:latitude])
      expect(json['longitude']).to eq(payload[:target][:longitude])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  context 'when the request is invalid' do
    before do
      payload[:target].delete(:topic_id)
      post '/api/v1/targets', params: payload, headers: auth_headers(user)
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(422)
    end

    it 'returns a validation failure message' do
      expect(json['message'])
        .to match('Validation failed: Topic must exist')
    end
  end
end

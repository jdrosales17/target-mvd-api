require 'rails_helper'

# Test suite for POST /api/v1/targets
describe 'POST /api/v1/targets', type: :request do
  let(:user)        { create(:user) }
  let(:other_user)  { create(:user) }
  let(:topic)       { create(:topic) }
  let(:payload)     { { target: attributes_for(:target, topic_id: topic.id) } }

  before(:each) { user.confirm }

  context 'when the request is valid' do
    before do
      post '/api/v1/targets', params: payload, headers: auth_headers(user)
    end

    it 'creates a target' do
      expect(json).not_to be_empty
      expect(json['target']['title']).to eq(payload[:target][:title])
      expect(json['target']['area_length']).to eq(payload[:target][:area_length])
      expect(json['target']['topic_id']).to eq(payload[:target][:topic_id])
      expect(json['target']['latitude']).to eq(payload[:target][:latitude])
      expect(json['target']['longitude']).to eq(payload[:target][:longitude])
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the request is valid and one compatible target is found' do
    before do
      create(:device, device_id: '1234', user_id: other_user.id)
      other_target = create(:target, topic_id: topic.id, user_id: other_user.id)
      new_compatible_target = attributes_for(
        :target,
        topic_id: other_target.topic_id,
        latitude: other_target.latitude,
        longitude: other_target.longitude
      )
      @payload = { target: new_compatible_target }
      post '/api/v1/targets', params: @payload, headers: auth_headers(user)
    end

    it 'creates a target' do
      expect(json).not_to be_empty
      expect(json['target']['title']).to eq(@payload[:target][:title])
      expect(json['target']['area_length']).to eq(@payload[:target][:area_length])
      expect(json['target']['topic_id']).to eq(@payload[:target][:topic_id])
      expect(json['target']['latitude']).to eq(@payload[:target][:latitude])
      expect(json['target']['longitude']).to eq(@payload[:target][:longitude])
    end

    it 'returns the other user that has a compatible target' do
      expect(json).not_to be_empty
      expect(json['compatible_users'][0]['id']).to eq(other_user.id)
      expect(json['compatible_users'][0]['name']).to eq(other_user.name)
      expect(json['compatible_users'][0]['nickname']).to eq(other_user.nickname)
      expect(json['compatible_users'][0]['image']['url']).to eq(other_user.image.url)
      expect(json['compatible_users'][0]['email']).to eq(other_user.email)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  context 'when the request is invalid' do
    before do
      payload[:target].delete(:topic_id)
      post '/api/v1/targets', params: payload, headers: auth_headers(user)
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a validation failure message' do
      expect(json['message'])
        .to match('Validation failed: Topic must exist')
    end
  end

  context 'when the user already has 10 targets created' do
    before do
      create_list(:target, 10, user_id: user.id)
      post '/api/v1/targets', params: payload, headers: auth_headers(user)
    end

    it 'returns status code 422' do
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'returns a validation failure message' do
      expect(json['message'])
        .to match("Validation failed: User #{I18n.t('api.targets.create.limit_reached', limit: Target::MAX_TARGETS_PER_USER)}")
    end
  end
end

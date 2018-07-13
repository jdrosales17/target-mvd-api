require 'rails_helper'

# Test suite for GET /api/v1/targets
describe 'GET /api/v1/targets', type: :request do
  let(:user)     { create(:user) }
  let!(:targets) { create_list(:target, 5, user_id: user.id) }

  before(:each) { user.confirm }

  context 'when the request is valid' do
    before { get '/api/v1/targets', headers: auth_headers(user) }

    it 'returns all targets of the user' do
      expect(json).not_to be_empty
      expect(json['targets'].size).to eq(targets.size)
      expect(json['targets'].map { |target| target['id'] }).to match_array(targets.pluck(:id))
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end

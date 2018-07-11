require 'rails_helper'

# Test suite for GET /api/v1/targets
describe 'GET /api/v1/targets', type: :request do
  let(:user) { create(:user) }
  let!(:targets) { create_list(:target, 5, user_id: user.id) }

  before(:each) do
    user.confirm
  end

  context 'when the request is valid' do
    before { get '/api/v1/targets', headers: auth_headers(user) }

    it 'returns all targets of the user' do
      expect(json).not_to be_empty
      expect(json['targets'].size).to eq(5)
      expect(targets.pluck(:id)).to match_array(json['targets'].map { |target| target['id'] })
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
end

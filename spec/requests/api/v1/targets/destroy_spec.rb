require 'rails_helper'

# Test suite for DELETE /api/v1/targets/:id
describe 'DELETE /api/v1/targets/:id', type: :request do
  let(:user)    { create(:user) }
  let!(:target) { create(:target, user_id: user.id) }

  before(:each) { user.confirm }

  context 'when the request is valid' do
    subject { delete "/api/v1/targets/#{target.id}", headers: auth_headers(user) }

    it 'deletes the target' do
      expect{ subject }.to change(user.reload.targets, :count).by(-1)
    end

    it 'returns status code 204' do
      subject
      expect(response).to have_http_status(:no_content)
    end
  end

  context 'when the target is not found' do
    before { Target.find(target.id).destroy }

    subject { delete "/api/v1/targets/#{target.id}", headers: auth_headers(user) }

    it 'does not delete the target' do
      expect{ subject }.not_to change(user.reload.targets, :count)
    end

    it 'returns status code 404' do
      subject
      expect(response).to have_http_status(:not_found)
    end
  end
end

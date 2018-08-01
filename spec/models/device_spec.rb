require 'rails_helper'

# Test suite for the Device model
RSpec.describe Device, type: :model do
  subject { create(:device) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:device_id) }
    it { is_expected.to validate_uniqueness_of(:device_id) }
  end
end

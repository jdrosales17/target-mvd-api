require 'rails_helper'

# Test suite for the Target model
RSpec.describe Target, type: :model do
  subject { create(:target) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
    it { is_expected.to belong_to(:topic) }
    it { is_expected.to belong_to(:user) }
  end
end

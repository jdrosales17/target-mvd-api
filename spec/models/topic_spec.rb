require 'rails_helper'

# Test suite for the Topic model
RSpec.describe Topic, type: :model do
  subject { create(:topic) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name) }
  end
end

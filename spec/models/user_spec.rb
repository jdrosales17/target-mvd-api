require 'rails_helper'

# Test suite for the User model
RSpec.describe User, type: :model do
  subject { create(:user) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_uniqueness_of(:nickname) }
    it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(20).on(:create) }
  end
end

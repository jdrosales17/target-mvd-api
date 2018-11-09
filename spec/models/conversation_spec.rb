require 'rails_helper'

RSpec.describe Conversation, type: :model do
  subject { create(:conversation_with_users_and_msgs) }

  context 'validations' do
    it { is_expected.to have_many(:messages) }
    it { is_expected.to have_many(:users) }
  end
end

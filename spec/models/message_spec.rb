require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { create(:message) }

  context 'validations' do
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to belong_to(:conversation) }
    it { is_expected.to belong_to(:sender) }
  end
end

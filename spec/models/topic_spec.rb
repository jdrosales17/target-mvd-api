require 'rails_helper'

# Test suite for the Topic model
RSpec.describe Topic, type: :model do
  before(:each) do
    @topic1 = create(:topic)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }

    it 'is valid with valid attributes' do
      expect(@topic1).to be_valid
    end
    
    it 'is not valid with repeated name' do
      topic2 = build(:topic, name: @topic1.name)
      expect(topic2).to_not be_valid
    end

    it 'is not valid without a name' do
      topic2 = build(:topic, name: nil)
      expect(topic2).to_not be_valid
    end
  end
end

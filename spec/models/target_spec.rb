require 'rails_helper'

# Test suite for the Target model
RSpec.describe Target, type: :model do
  before(:each) do
    @target1 = create(:target)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }

    it 'is valid with valid attributes' do
      expect(@target1).to be_valid
    end
    
    it 'is not valid with repeated title' do
      target2 = build(:target, title: @target1.title)
      expect(target2).to_not be_valid
    end

    it 'is not valid without a title' do
      target2 = build(:target, title: nil)
      expect(target2).to_not be_valid
    end
    
    it 'is not valid without a latitude' do 
      target2 = build(:target, latitude: nil)
      expect(target2).to_not be_valid
    end

    it 'is not valid without a longitude' do 
      target2 = build(:target, longitude: nil)
      expect(target2).to_not be_valid
    end
  end
end

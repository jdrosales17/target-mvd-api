require 'rails_helper'

# Test suite for the User model
RSpec.describe User, type: :model do
  before(:all) do
    @user1 = create(:user)
  end

  context 'validations' do
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_length_of(:password).is_at_least(8).is_at_most(20).on(:create) }

    it 'is valid with valid attributes' do
      expect(@user1).to be_valid
    end
    
    it 'is not valid with repeated email' do
      user2 = build(:user, email: @user1.email)
      expect(user2).to_not be_valid
    end
    
    it 'is not valid with repeated nickname' do
      user2 = build(:user, nickname: @user1.nickname)
      expect(user2).to_not be_valid
    end

    it 'is not valid without an email' do
      user2 = build(:user, email: nil)
      expect(user2).to_not be_valid
    end
    
    it 'is not valid without a password' do 
      user2 = build(:user, password: nil)
      expect(user2).to_not be_valid
    end
  end
end

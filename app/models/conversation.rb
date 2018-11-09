# == Schema Information
#
# Table name: conversations
#
#  id         :bigint(8)        not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :conversations_users
  has_many :users, through: :conversations_users

  def self.create_for_2(user1, user2)
    return if already_exists?(user1, user2)
    conversation = user1.conversations.create!
    user2.conversations << conversation
    conversation
  end

  def self.already_exists?(user1, user2)
    result = false
    user1.conversations.each do |c|
      result = true if c.users.include?(user2)
    end
    result
  end

  private_class_method :already_exists?
end

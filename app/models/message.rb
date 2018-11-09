# == Schema Information
#
# Table name: messages
#
#  id              :bigint(8)        not null, primary key
#  content         :string           not null
#  conversation_id :bigint(8)
#  user_id         :bigint(8)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (user_id => users.id)
#

class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :sender, class_name: :User, foreign_key: 'user_id'

  validates :content, presence: true

  validate :sender_from_conversation

  after_create_commit do
    MessageBroadcastJob.perform_later(self)
    notify_new_message
  end

  private

  def sender_from_conversation
    unless conversation.users.include?(sender)
      errors.add(:sender, I18n.t('api.messages.create.invalid_sender'))
    end
  end

  def notify_new_message
    conversation.users.where.not(id: sender.id).each do |target_user|
      NotifyNewMessageJob.perform_later(
        target_user.devices.pluck(:device_id),
        sender.name,
        content
      )
    end
  end
end

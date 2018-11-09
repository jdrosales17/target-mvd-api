class MessageBroadcastJob < ApplicationJob
  queue_as :default

  def perform(message)
    payload = {
      id: message.id,
      content: message.content,
      sender: message.sender
    }
    RoomChannel.broadcast_to(message.conversation, payload)
  end
end

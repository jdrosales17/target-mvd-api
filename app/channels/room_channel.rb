class RoomChannel < ApplicationCable::Channel
  # When a client connects to the server
  def subscribed
    stream_for conversation if params[:room_id].present?
  end

  # When a client broadcasts data
  def send_message(data)
    raise 'No message!' if data['message'].blank?
    Message.create!(
      conversation: conversation,
      sender: current_user,
      content: data['message']
    )
  end

  # Helper methods

  def conversation
    Conversation.find_by_id(params[:room_id])
  end
end

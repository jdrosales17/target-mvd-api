require 'rails_helper'

describe RoomChannel, type: :channel do
  let!(:user)         { create(:user) }
  let!(:conversation) { create(:conversation, users: [user]) }

  it 'successfully subscribes' do
    subscribe(room_id: conversation.id)
    expect(subscription).to be_confirmed
  end

  it 'successfully performs sending a message' do
    stub_connection(current_user: user)
    subscribe(room_id: conversation.id)

    perform :send_message, message: 'Hey'
    expect(Message.last.content).to eq('Hey')
  end
end

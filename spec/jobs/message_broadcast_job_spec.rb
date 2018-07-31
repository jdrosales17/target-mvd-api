require 'rails_helper'

describe MessageBroadcastJob, type: :job do
  let!(:message) { create(:message) }

  describe '#perform' do
    before(:each) { ActiveJob::Base.queue_adapter = :test }

    it 'calls the room channel to broadcast the message' do
      expect(RoomChannel).to receive(:broadcast_to)
        .with(message.conversation, anything)

      MessageBroadcastJob.perform_now(message)
    end

    it 'broadcasts the message to the conversation' do
      expect { MessageBroadcastJob.perform_now(message) }
        .to have_broadcasted_to(message.conversation)
        .from_channel(RoomChannel)
        .with(a_hash_including(content: message.content))
    end
  end
end

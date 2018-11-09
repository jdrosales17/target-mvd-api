require 'rails_helper'

describe NotifyNewMessageJob, type: :job do
  let(:user)         { create(:user) }
  let(:other_user)   { create(:user) }
  let(:conversation) { create(:conversation, users: [user, other_user]) }
  let(:message) do
    create(
      :message,
      sender: user,
      conversation: conversation
    )
  end

  describe '#perform' do
    before(:each) { ActiveJob::Base.queue_adapter = :test }

    it 'calls One Signal service to send the notification' do
      expect(OneSignalService).to receive(:send_notification)
        .with(
          other_user.devices.pluck(:device_id),
          message.sender.name,
          message.content
        )

      NotifyNewMessageJob.perform_now(
        other_user.devices.pluck(:device_id),
        message.sender.name,
        message.content
      )
    end
  end
end

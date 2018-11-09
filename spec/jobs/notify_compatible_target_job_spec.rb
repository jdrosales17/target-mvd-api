require 'rails_helper'

describe NotifyCompatibleTargetJob, type: :job do
  let(:user)    { create(:user) }
  let(:devices) { create_list(:device, 3, user: user) }

  describe '#perform' do
    before(:each) { ActiveJob::Base.queue_adapter = :test }

    it 'calls One Signal service to send the notification' do
      expect(OneSignalService).to receive(:send_notification)
        .with(
          devices.pluck(:device_id),
          I18n.t('api.notifications.titles.new_compatible_target'),
          I18n.t('api.notifications.messages.new_compatible_target')
        )

      NotifyCompatibleTargetJob.perform_now(devices.pluck(:device_id))
    end
  end
end

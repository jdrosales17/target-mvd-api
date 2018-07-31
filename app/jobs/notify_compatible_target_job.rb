class NotifyCompatibleTargetJob < ApplicationJob
  queue_as :default
  retry_on RuntimeError

  def perform(device_ids)
    OneSignalService.send_notification(
      device_ids,
      I18n.t('api.notifications.titles.new_compatible_target'),
      I18n.t('api.notifications.messages.new_compatible_target')
    )
  end
end

class NotifyNewMessageJob < ApplicationJob
  queue_as :default
  retry_on RuntimeError

  def perform(device_ids, title, message)
    OneSignalService.send_notification(device_ids, title, message)
  end
end

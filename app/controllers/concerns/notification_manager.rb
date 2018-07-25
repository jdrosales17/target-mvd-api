module NotificationManager
  extend ActiveSupport::Concern

  def notify(device_ids, title, message)
    OneSignalService.send_notification(device_ids, title, message)
  end
end

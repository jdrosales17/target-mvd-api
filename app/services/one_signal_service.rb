module OneSignalService
  extend self
  include HTTParty

  # Setting base uri, headers, default params and timeout for every request
  base_uri 'https://onesignal.com/api/v1'
  headers 'Content-Type': 'application/json;charset=utf-8'
  headers 'Authorization': "Basic #{ENV['ONE_SIGNAL_REST_API_KEY']}"
  default_params app_id: ENV['ONE_SIGNAL_APP_ID']
  default_timeout 5

  def send_notification(device_ids, title, message)
    params = {
      include_player_ids: device_ids,
      headings: { 'en': title },
      contents: { 'en': message }
    }
    post('/notifications', body: params.to_json)
  rescue HTTParty::Error, SocketError
    raise I18n.t('api.errors.one_signal')
  end
end

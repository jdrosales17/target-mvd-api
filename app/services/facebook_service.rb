class FacebookService
  def initialize(access_token)
    @access_token = access_token
  end

  def profile
    client.get_object(
      'me',
      fields: 'email, name, first_name, picture.type(large)'
    )
  end

  private

  def client
    Koala::Facebook::API.new(@access_token, ENV['FACEBOOK_APP_SECRET'])
  end
end

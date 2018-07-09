module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end

  # Generate random latitude and longitude
  def random_location
    { latitude: rand(-90.0...90.0).round(6), longitude: rand(-180.0...180.0).round(6) }
  end

  # Generate auth headers
  def auth_headers(user)
    user.create_new_auth_token
  end
end

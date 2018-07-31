json.id      message.id
json.content message.content
json.sender do
  json.partial! '/api/v1/users/user', user: message.sender
end

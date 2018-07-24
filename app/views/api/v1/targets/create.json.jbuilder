json.target do
  json.partial! 'target', target: @target
end
json.compatible_users do
  json.array!(
    @compatible_users,
    partial: '/api/v1/compatible_users/compatible_user',
    as: :compatible_user
  )
end

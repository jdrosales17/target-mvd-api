json.compatible_users do
  json.array!(
    @compatible_users,
    partial: 'compatible_user',
    as: :compatible_user
  )
end

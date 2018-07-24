json.target do
  json.partial! 'target', target: @target
end
json.compatible_users do
  json.array!(
    @compatible_users,
    :id,
    :name,
    :nickname,
    :image,
    :email
  )
end

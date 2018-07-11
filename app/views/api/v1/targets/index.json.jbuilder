json.targets do
  json.array! @targets, :id, :title, :area_length, :topic_id, :latitude, :longitude
end

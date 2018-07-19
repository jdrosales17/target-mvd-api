json.targets do
  json.array!(@targets, partial: 'target', as: :target)
end

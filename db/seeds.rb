# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

topics_list = %w[Travel Sports Study Work]

topics_list.each do |name|
  Topic.create(name: name)
end

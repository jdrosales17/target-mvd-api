FactoryBot.define do
  factory :target do
    sequence(:title) { |n| "#{n} #{Faker::Pokemon.location}" }
    area_length  { Faker::Number.between(1, 100) }
    latitude     { Float(Faker::Address.latitude).round(6) }
    longitude    { Float(Faker::Address.longitude).round(6) }
    topic
    user
  end
end

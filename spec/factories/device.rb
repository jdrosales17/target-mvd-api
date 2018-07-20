FactoryBot.define do
  factory :device do
    device_id { Faker::Bitcoin.address }
    user
  end
end

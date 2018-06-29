FactoryBot.define do
  factory :user do
    name              { Faker::Name.name }
    nickname          { Faker::Name.first_name }
    remote_image_url  { Faker::Avatar.image }
    email             { Faker::Internet.email }
    password          { Faker::Internet.password(8, 20) }
  end
end

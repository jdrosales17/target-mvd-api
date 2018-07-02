FactoryBot.define do
  factory :user do
    name      { Faker::Name.name }
    nickname  { Faker::Name.first_name }
    image     { 'data:image/jpeg;base64,' + Base64.encode64(File.open("#{Rails.root.to_s}/public/assets/test_image.jpeg").read) }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password(8, 20) }
  end
end

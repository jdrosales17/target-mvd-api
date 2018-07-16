FactoryBot.define do
  test_image_path = "#{Rails.root}/public/assets/test_image.jpeg"
  test_image_base64 = Base64.encode64(File.open(test_image_path).read)

  factory :user do
    name      { Faker::Name.name }
    nickname  { Faker::Name.first_name }
    image     { "data:image/jpeg;base64,#{test_image_base64}" }
    email     { Faker::Internet.email }
    password  { Faker::Internet.password(8, 20) }
  end
end

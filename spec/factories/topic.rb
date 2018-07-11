FactoryBot.define do
  factory :topic do
    name { Faker::Company.industry }
  end
end

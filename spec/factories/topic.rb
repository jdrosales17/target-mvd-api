FactoryBot.define do
  factory :topic do
    sequence(:name) { |n| "#{n} #{Faker::Company.industry}" }
  end
end

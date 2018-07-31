FactoryBot.define do
  factory :message do
    content { Faker::StarWars.quote }
    association :sender, factory: :user
    conversation { create(:conversation, users: [sender]) }
  end
end

FactoryBot.define do
  factory :conversation do
    factory :conversation_with_users_and_msgs do
      transient do
        user_1    { create(:user) }
        user_2    { create(:user) }
        msg_count 1
      end

      after(:create) do |conversation, evaluator|
        conversation.users << evaluator.user_1
        conversation.users << evaluator.user_2
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation,
          sender: evaluator.user_1
        )
        create_list(
          :message,
          evaluator.msg_count,
          conversation: conversation,
          sender: evaluator.user_2
        )
      end
    end
  end
end

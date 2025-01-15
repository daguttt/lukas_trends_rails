FactoryBot.define do
  factory :chat do
    question { 'MyString' }
    reply { 'MyText' }

    association :user
  end
end

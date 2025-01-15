FactoryBot.define do
  factory :user do
    full_name { 'MyString' }
    password { 'MyString' }
    email { 'MyString' }
    subscription_type { 1 }
    role { 1 }
    preferences { '' }
  end
end

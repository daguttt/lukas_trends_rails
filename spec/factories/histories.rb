FactoryBot.define do
  factory :history do
    date { '2025-01-15' }
    lukas_value { '20000.00' }

    association :currency
  end
end

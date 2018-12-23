FactoryBot.define do
  factory :token, class: Customer::Token do
    token { 'test_token' }
  end
end

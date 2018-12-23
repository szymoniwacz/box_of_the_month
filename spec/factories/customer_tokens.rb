FactoryBot.define do
  factory :customer_token, class: 'Customer::Token' do
    token { 'MyString' }
  end
end

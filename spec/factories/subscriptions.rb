FactoryBot.define do
  factory :subscription do
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    zip_code "01001"
    card_number "4242424242424242"
    expiration_date "01/2024"
    cvv "123"
    billing_zip_code "10100"
    plan_id nil
  end
end

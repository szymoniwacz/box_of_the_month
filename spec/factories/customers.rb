FactoryBot.define do
  factory :customer do
    name { "MyString" }
    address { "MyString" }
    zip_code { "MyString" }

    factory :customer_with_token do
      after(:create) do |customer|
        create(:token, customer_id: customer.id)
      end
    end
  end

  factory :invalid_customer, class: Customer do
  end
end

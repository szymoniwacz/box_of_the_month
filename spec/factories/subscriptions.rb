FactoryBot.define do
  factory :subscription do
    # name { Faker::Name.name }
    # address { Faker::Address.full_address }
    # zip_code "01001"
    card_number { '4242424242424242' }
    expiration_date { '01/2024' }
    cvv { '123' }
    billing_zip_code { '10100' }
    plan_id { Plan.first.id }
  end

  factory :test_subscription, class: Subscription do
    # name { Faker::Name.name }
    # address { Faker::Address.full_address }
    # zip_code "01001"
    plan_id { Plan.first.id }
    customer_id { nil }

    factory :test_subscription_with_payment do
      after(:create) do |subscription|
        create(:payment, subscription_id: subscription.id,
                         amount: subscription.plan.price)
      end
    end
  end

  factory :invalid_subscription, class: Subscription do
    name { Faker::Name.name }
  end
end

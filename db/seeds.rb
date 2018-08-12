puts "Creating plans"
Plan.find_or_create_by(name: "Bronze Box", price: "19.99", currency: "USD")
Plan.find_or_create_by(name: "Silver Box", price: "49", currency: "USD")
Plan.find_or_create_by(name: "Gold Box", price: "99", currency: "USD")

selected_plan = Plan.first

s = Subscription.find_or_create_by(name: "Nazwa", address: "Sample Address", zip_code: "01001", plan_id: selected_plan.id)

puts "Creating payments"
Payment.find_or_create_by(token: "890ad4852000d607db3f37f3a62013", success: true, error_code: nil, subscription_id: s.id, amount: selected_plan.price)
Payment.find_or_create_by(token: nil, success: false, error_code: "1000001", subscription_id: s.id, amount: selected_plan.price)

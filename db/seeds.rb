# frozen_string_literal: true

puts 'Creating plans'
Plan.find_or_create_by(name: 'Bronze Box', price: '19.99', currency: 'USD')
Plan.find_or_create_by(name: 'Silver Box', price: '49', currency: 'USD')
Plan.find_or_create_by(name: 'Gold Box', price: '99', currency: 'USD')

puts 'Creating customer'
customer = Customer.find_or_create_by(name: 'Nazwa', address: 'Sample Address', zip_code: '01001')
token = customer.create_token
puts "Customer's token: #{token.token}"

selected_plan = Plan.first

s = customer.subscriptions.find_or_create_by(plan_id: selected_plan.id, status: 'active')

puts 'Creating payments'
s.payments.find_or_create_by(token: '890ad4852000d607db3f37f3a62013', success: true, error_code: nil, amount: selected_plan.price)
s.payments.find_or_create_by(token: nil, success: false, error_code: '1000001', amount: selected_plan.price)

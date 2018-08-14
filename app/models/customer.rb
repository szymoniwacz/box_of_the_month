class Customer < ApplicationRecord
  has_one :token
  has_many :subscriptions
  has_many :payments, through: :subscriptions
end

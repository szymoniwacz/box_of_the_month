class Customer < ApplicationRecord
  has_one :token
  has_many :subscriptions
end

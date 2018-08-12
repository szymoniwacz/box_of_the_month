class Subscription < ApplicationRecord
  has_many :payments
  belongs_to :plan
  belongs_to :customer
end

class Subscription < ApplicationRecord
  has_many :payments
  belongs_to :plan
end

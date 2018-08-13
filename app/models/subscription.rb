class Subscription < ApplicationRecord
  NEW      = :new
  ACTIVE   = :active
  CANCELED = :canceled

  has_many :payments
  belongs_to :plan
  belongs_to :customer

  scope :active, -> { where(status: ACTIVE) }
end

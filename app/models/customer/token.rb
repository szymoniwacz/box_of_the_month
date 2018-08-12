class Customer::Token < ApplicationRecord
  belongs_to :customer

  before_create :generate_token

  private

  def generate_token
    token = SecureRandom.uuid
    token = SecureRandom.uuid until Customer::Token.find_by_token(token).nil?
    self.token = token
  end
end

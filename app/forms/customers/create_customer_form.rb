module Customers
  class CreateCustomerForm < Form
    attribute :name, String
    attribute :address, String
    attribute :zip_code, String

    validates :name, :address, :zip_code,
              presence: true

    validates :name,
              uniqueness: { model: Customer }
  end
end

module Customers
  class CustomerSerializer < ActiveModel::Serializer
    attributes :id, :name, :address, :zip_code, :token

    def token
      Customer::Token.find_by(customer_id: object.id).try(:token)
    end
  end
end

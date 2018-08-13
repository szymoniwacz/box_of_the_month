module Customers
  class CustomerSerializer < BaseSerializer
    attributes :href, :id, :name, :address, :zip_code, :token

    def href
      v1_customer_url(object.id)
    end

    def token
      Customer::Token.find_by(customer_id: object.id).try(:token)
    end
  end
end

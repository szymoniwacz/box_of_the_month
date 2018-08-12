module Customers
  class CreateCustomer
    include Service

    def initialize(attrs = {})
      @form = attrs.fetch(:form)
    end

    def call
      return build_result(validation_error) if form.invalid?
      @customer = Customer.create(form.to_hash)
      @customer.create_token
      build_result(@customer)
    end
  end
end

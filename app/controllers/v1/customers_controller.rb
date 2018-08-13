module V1
  class CustomersController < ApplicationController

    before_action :authorize_customer!, only: [:show]

    def create
      form = Customers::CreateCustomerForm.new(customer_params)
      result = Customers::CreateCustomer.call(form: form)
      if result.error?
        render_error(result.object)
      else
        render json: result.object,
               serializer: Customers::CustomerSerializer,
               status: :created
      end
    end

    def show
      render json: customer,
             serializer: Customers::CustomerSerializer
    end

    private

    def customer_params
      @customer_params ||= params.permit(:name, :address, :zip_code)
    end
  end
end

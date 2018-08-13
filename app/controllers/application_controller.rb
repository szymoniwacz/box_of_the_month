class ApplicationController < ActionController::API
  include ErrorHandler

  def info
    render json: BoxOfTheMonthAPI.info, status: :ok
  end

  def default_url_options
    super.merge(host: Settings.host)
  end

  private

  def allow_page_caching
    expires_in(Settings.cache.static_page.expires_in)
  end

  def authorize_customer!
    raise Error::Forbidden.new unless customer_authorized?
  end

  def customer_authorized?
    return false if customer.blank?
    true
  end

  def customer
    @customer ||= customer_token.try(:customer)
  end

  def customer_token
    @customer_token = Customer::Token.find_by(token: request.headers['Authorization'])
  end
end

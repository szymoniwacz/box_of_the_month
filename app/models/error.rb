class Error < StandardError
  include ActiveModel::Serialization

  attr_reader :key, :details, :http_status

  def initialize(message, key, details = {}, http_status = nil)
    super(message)
    @key = key.to_sym
    @details = details
    @http_status = http_status
  end

  def as_json(_args = nil)
    {
      status: http_status,
      error: key,
      message: message,
      details: details
    }
  end
end

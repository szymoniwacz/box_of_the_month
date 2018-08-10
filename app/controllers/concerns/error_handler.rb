module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle
  end

  def routing_not_found
    error = Error::RoutingNotFound.new(request)
    render_error error
  end

  private

  def handle(error)
    # render json: error, serializer: ErrorSerializer, status: error.http_status
  end
end

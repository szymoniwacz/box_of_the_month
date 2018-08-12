module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :handle
  end

  # def routing_not_found
  #   error = Error::RoutingNotFound.new(request)
  #   render_error error
  # end

  private

  def handle(error)
    if error.is_a?(Error)
      render_error(error)
    elsif error.is_a?(ActiveRecord::RecordNotFound)
      render_error Error::ResourceNotFound.new(error.message)
    else
      render_error Error::InternalServerError.new(nil, error)
    end
  end

  def render_error(object)
    # render json: object, serializer: ErrorSerializer, status: object.status
    render json: object.as_json, status: object.as_json[:status]
  end
end

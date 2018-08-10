class ApplicationController < ActionController::API
  include ErrorHandler

  def info
    render json: BoxOfTheMonthAPI.info, status: :ok
  end
end

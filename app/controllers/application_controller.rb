class ApplicationController < ActionController::API
  include ErrorHandler

  def info
    render json: BoxOfTheMonthAPI.info, status: :ok
  end

  private

  def allow_page_caching
    expires_in(Settings.cache.static_page.expires_in)
  end
end

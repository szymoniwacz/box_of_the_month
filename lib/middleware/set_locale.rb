module Middleware
  class SetLocale
    def initialize(app)
      @app = app
    end

    def call(env)
      old_locale = I18n.locale

      begin
        locale = check_locale(env) || I18n.default_locale
        env['rack.locale'] = I18n.locale = locale.to_s
        status, headers, body = @app.call(env)
        [status, headers, body]
      ensure
        I18n.locale = old_locale
      end
    end

    private

    def check_locale(env)
      accept_language = env['HTTP_ACCEPT_LANGUAGE']
      return if accept_language.nil?
      return unless I18n.available_locales.map(&:to_s).include?(accept_language.to_s)

      accept_language
    end
  end
end

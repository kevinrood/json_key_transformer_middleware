require 'rails/railtie'

module JsonKeyTransformerMiddleware

  class Railtie < Rails::Railtie

    config.app_middleware.insert_after Rails::Rack::Logger, JsonKeyTransformerMiddleware::IncomingParamsFormatter
    config.app_middleware.insert_after Rails::Rack::Logger, JsonKeyTransformerMiddleware::IncomingJsonFormatter
    config.app_middleware.use JsonKeyTransformerMiddleware::OutgoingJsonFormatter

  end

end

require 'rails/railtie'

module JsonKeyTransformerMiddleware

  class Railtie < Rails::Railtie

    config.json_key_transformer_middleware = ActiveSupport::OrderedOptions.new
    config.json_key_transformer_middleware.incoming_strategy = :transform_camel_to_underscore
    config.json_key_transformer_middleware.incoming_strategy_options = ActiveSupport::OrderedOptions.new
    config.json_key_transformer_middleware.outgoing_strategy = :transform_underscore_to_camel
    config.json_key_transformer_middleware.outgoing_strategy_options = ActiveSupport::OrderedOptions.new
    config.json_key_transformer_middleware.skip_paths = []

    config.app_middleware.insert_after(Rails::Rack::Logger, JsonKeyTransformerMiddleware::IncomingParamsFormatter, config.json_key_transformer_middleware)
    config.app_middleware.insert_after(Rails::Rack::Logger, JsonKeyTransformerMiddleware::IncomingJsonFormatter, config.json_key_transformer_middleware)
    config.app_middleware.use(JsonKeyTransformerMiddleware::OutgoingJsonFormatter, config.json_key_transformer_middleware)

  end

end

require 'hash_key_transformer'
require 'oj'

module JsonKeyTransformerMiddleware

  class IncomingParamsFormatter < Middleware

    def call(env)
      unless should_skip?(env)
        parsed_params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
        transformed_params = HashKeyTransformer.send(middleware_config.incoming_strategy, parsed_params, middleware_config.incoming_strategy_options)
        env['QUERY_STRING'] = Rack::Utils.build_nested_query(transformed_params)
      end

      @app.call(env)
    end

  end

end

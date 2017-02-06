require 'oj'

module JsonKeyTransformerMiddleware

  class IncomingParamsFormatter < Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      parsed_params = Rack::Utils.parse_nested_query(env['QUERY_STRING'])
      transformed_params = deep_transform_hash_keys(parsed_params, :camel_to_underscore)
      env['QUERY_STRING'] = Rack::Utils.build_nested_query(transformed_params)

      @app.call(env)
    end

  end

end

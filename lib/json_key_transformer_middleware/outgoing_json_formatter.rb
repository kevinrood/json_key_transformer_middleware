require 'oj'

module JsonKeyTransformerMiddleware

  class OutgoingJsonFormatter < Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      new_body = body.each.map do |body_part|
        Oj.dump(
          deep_transform_hash_keys(
            Oj.load(body_part), :underscore_to_camel))
      end

      [status, headers, new_body]
    end

  end

end

require 'oj'

module JsonKeyTransformerMiddleware

  class IncomingJsonFormatter < Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      result =
        Oj.dump(
          deep_transform_hash_keys(
            Oj.load(env['rack.input'].read), :camel_to_underscore))

      env['rack.input'] = StringIO.new(result)
      # Rails uses this elsewhere to parse 'rack.input', it must be updated to avoid truncation
      env['CONTENT_LENGTH'] = result.length.to_s

      @app.call(env)
    end

  end

end

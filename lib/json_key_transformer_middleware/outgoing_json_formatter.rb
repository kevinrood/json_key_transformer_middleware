require 'oj'

module JsonKeyTransformerMiddleware

  class OutgoingJsonFormatter < Middleware

    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = @app.call(env)

      new_body = build_new_body(body)

      [status, headers, new_body]
    end

    private

    def build_new_body(body)
      Enumerator.new do |yielder|
        body.each do |body_part|
          yielder << (body_part != '' ? transform_outgoing_body_part(body_part) : '')
        end
      end
    end

    def transform_outgoing_body_part(body_part)
      begin
        Oj.dump(
          deep_transform_hash_keys(
            Oj.load(body_part), :underscore_to_camel))
      rescue
        body_part
      end
    end

  end

end

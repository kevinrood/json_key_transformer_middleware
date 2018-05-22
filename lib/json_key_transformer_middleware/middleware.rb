module JsonKeyTransformerMiddleware

  class Middleware
    def initialize(app, middleware_config)
      @app = app
      @middleware_config = middleware_config
    end

    private

    attr_reader :app, :middleware_config
  end

end

module JsonKeyTransformerMiddleware

  class Middleware
    def initialize(app, middleware_config)
      @app = app
      @middleware_config = middleware_config
    end

    protected

    def should_skip?(env)
      middleware_config.skip_paths.any? do |skip_path|
        case skip_path
        when String
          skip_path == env['PATH_INFO']
        when Regexp
          skip_path.match? env['PATH_INFO']
        end
      end
    end

    private

    attr_reader :app, :middleware_config

  end

end

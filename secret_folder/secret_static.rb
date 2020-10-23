# frozen_string_literal: true

require 'pry'
class SecretFolder
  class SecretStatic
    def initialize(app)
      @app = app
    end

    def call(env)
      if can_response_with_file?(env['PATH_INFO'])
        Rack::Files.new(Dir.pwd).call(env)
      else
        @app.call(env)
      end
    end

    private

    def can_response_with_file?(path)
      allowed_path = %w[public assets .css .js]
      path.match(Regexp.union(allowed_path))
    end
  end
end

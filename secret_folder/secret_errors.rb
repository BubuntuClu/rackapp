# frozen_string_literal: true

require 'pry'
class SecretFolder
  class SecretErrors
    def initialize(app)
      @app = app
    end

    def call(env)
      status, header, body = @app.call(env)

      if [404, 500].include?(status)
        env['PATH_INFO'] = "/public/#{status}.html"
        header['Content-Type'] = 'text/html'
        _status, _header, body = Rack::Files.new(Dir.pwd).call(env)
      end

      [status, header, body]
    end
  end
end

# frozen_string_literal: true

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
      permitted_files = Dir.entries('public')
      requested_file = path.split('/').last

      permitted_files.include?(requested_file)
    end
  end
end

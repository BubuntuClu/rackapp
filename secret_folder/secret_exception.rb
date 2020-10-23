# frozen_string_literal: true

require 'pry'
class SecretFolder
  class SecretException
    def initialize(app)
      @app = app
    end

    def call(env)
      @app.call(env)
    rescue StandardError => e
      [500, {}, [e]]
    end
  end
end

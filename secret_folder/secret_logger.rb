# frozen_string_literal: true

require 'logger'

class SecretFolder
  class SecretLogger
    def initialize(app, **options)
      @logger = options[:logger]
      @app = app
    end

    def call(env)
      start_time = Time.now
      status, header, body = @app.call(env)
      taken_time = Time.now - start_time
      @logger.info(log_message(env, status, taken_time, body))

      [status, header, body]
    end

    private

    def log_message(env, status, taken_time, _body)
      "REQUEST: REQUESTED PATH -  #{env['REQUEST_PATH']}; REQUEST STARTED AT - #{Time.now}"\
      "\n" \
      "RESPONSE: RESPONSE WITH STATUS - #{status}; TAKEN TIME - #{taken_time}"
    end
  end
end

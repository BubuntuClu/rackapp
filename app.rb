# frozen_string_literal: true

require 'pry'
class App
  def call(env)
    raise if env['PATH_INFO'] == '/raise_500'

    if env['PATH_INFO'] == '/'
      [200, {}, ['Hello world']]
    else
      [404, {}, []]
    end
  rescue StandardError
    [500, {}, []]
  end
end

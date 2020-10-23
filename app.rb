# frozen_string_literal: true

require 'pry'
class App
  def call(env)
    if env['PATH_INFO'] == '/'
      [200, {}, ['Hello world']]
    else
      [404, {}, []]
    end
  end
end

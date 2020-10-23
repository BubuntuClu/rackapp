# frozen_string_literal: true

require './secret_folder/secret_logger'
require './app'
require 'rack'

RSpec.describe SecretFolder::SecretLogger do
  subject { described_class.new(app) }

  let(:request) { Rack::MockRequest.env_for('http://example.com:8080/') }
  let(:app) { App.new }

  it 'creates log' do
    # how to check logs?(
    expect { subject.call(request) }.to output(/REQUEST/).to_stdout
  end
end

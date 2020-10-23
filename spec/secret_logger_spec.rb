# frozen_string_literal: true

require './secret_folder/secret_logger'
require './app'
require 'rack'

RSpec.describe SecretFolder::SecretLogger do
  subject { described_class.new(app, logger: logger) }

  let!(:output_stream) { StringIO.new }
  let(:logger) { Logger.new(output_stream) }

  let(:request) { Rack::MockRequest.env_for('http://example.com:8080/') }
  let(:app) { ->(_) { [200, {}, ['123']] } }

  it 'creates log' do
    subject.call(request)

    expect(output_stream.string).to include 'REQUEST: REQUESTED PATH'
    expect(output_stream.string).to include 'RESPONSE: RESPONSE WITH STATUS'
  end
end

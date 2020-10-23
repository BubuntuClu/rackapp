# frozen_string_literal: true

require './secret_folder/secret_static'
require './app'
require 'rack'

RSpec.describe SecretFolder::SecretStatic do
  subject { described_class.new(app) }

  let(:request) { Rack::MockRequest.env_for('http://example.com:8080/public/dogs.jpg') }
  let(:app) { App.new }

  it 'returns static file' do
    response = subject.call(request)

    expect(response[0]).to eq 200
    expect(response[1]['Content-Type']).to eq 'image/jpeg'
  end
end

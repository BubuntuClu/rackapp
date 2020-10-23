# frozen_string_literal: true

require './secret_folder/secret_static'
require 'rack'

RSpec.describe SecretFolder::SecretStatic do
  subject { described_class.new(app) }

  context 'valid file' do
    let(:app) { ->(_) { [200, {}, []] } }
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/public/dogs.jpg') }

    it 'returns static file' do
      response = subject.call(request)

      expect(response[0]).to eq 200
      expect(response[1]['Content-Type']).to eq 'image/jpeg'
    end
  end

  context 'invalid file' do
    let(:app) { ->(_) { [404, {}, []] } }
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/public/dsogs.jpg') }

    it 'returns 404 file' do
      response = subject.call(request)

      expect(response[0]).to eq 404
      expect(response[1]['Content-Type']).to eq 'text/plain'
    end
  end
end

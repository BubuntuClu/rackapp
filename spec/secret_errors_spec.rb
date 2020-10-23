# frozen_string_literal: true

require './secret_folder/secret_errors'
require 'rack'

RSpec.describe SecretFolder::SecretErrors do
  subject { described_class.new(app) }

  context '404' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/asd') }
    let(:app) { ->(_) { [404, {}, []] } }

    it 'returns 404 page' do
      response = subject.call(request)

      expect(response[0]).to eq 404
      expect(response[1]['Content-Type']).to eq 'text/html'
    end
  end

  context '500' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/qwe') }
    let(:app) { ->(_) { [500, {}, []] } }

    it 'returns 500 page' do
      response = subject.call(request)

      expect(response[0]).to eq 500
      expect(response[1]['Content-Type']).to eq 'text/html'
    end
  end

  context '200' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/') }
    let(:app) { ->(_) { [200, {}, ['123']] } }

    it 'returns hello world' do
      response = subject.call(request)

      expect(response[0]).to eq 200
      expect(response[2]).to eq ['123']
    end
  end
end

# frozen_string_literal: true

require './secret_folder/secret_errors'
require './app'
require 'rack'

RSpec.describe SecretFolder::SecretErrors do
  subject { described_class.new(app) }

  let(:app) { App.new }

  context '404' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/asd') }

    it 'returns 404 page' do
      response = subject.call(request)

      expect(response[0]).to eq 404
      expect(response[1]['Content-Type']).to eq 'text/html'
    end
  end

  context '500' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/raise_500') }

    it 'returns 500 page' do
      response = subject.call(request)

      expect(response[0]).to eq 500
      expect(response[1]['Content-Type']).to eq 'text/html'
    end
  end

  context '200' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/') }

    it 'returns hello world' do
      response = subject.call(request)

      expect(response[0]).to eq 200
      expect(response[2]).to eq ['Hello world']
    end
  end
end

# frozen_string_literal: true

require 'rspec_helper'
require 'rack'
require 'rack/mock'
require 'pry'

describe App do
  let(:app) { described_class.new }
  let(:response) { app.call(request) }
  let(:body)     { response[2] }
  let(:status)   { response[0] }

  context 'valid path' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/') }

    it 'returns status 200' do
      expect(status).to eq 200
    end

    it 'returns body' do
      expect(body).to eq ['Hello world']
    end
  end

  context 'not found path' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/asd') }

    it 'returns status 404' do
      expect(status).to eq 404
    end

    it 'returns body' do
      expect(body).to eq []
    end
  end

  context 'exception path' do
    let(:request) { Rack::MockRequest.env_for('http://example.com:8080/raise_500') }

    it 'returns status 500' do
      expect(status).to eq 500
    end

    it 'returns body' do
      expect(body).to eq []
    end
  end
end

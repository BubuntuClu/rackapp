# frozen_string_literal: true

require 'rspec_helper'

describe App do
  context 'get root' do
    let(:app) { described_class.new }
    let(:env)      { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/anything' } }
    let(:response) { app.call(env) }
    let(:body)     { response[2][0] }
    let(:status)   { response[0] }

    it 'returns the status 200' do
      expect(status).to eq 200
    end

    it 'returns the body' do
      expect(body).to eq 'Hello world'
    end
  end
end

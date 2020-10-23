# frozen_string_literal: true

require './secret_folder/secret_exception'
require 'rack'

RSpec.describe SecretFolder::SecretException do
  subject { described_class.new(app) }

  let(:app) { ->(_) { raise } }
  let(:request) { Rack::MockRequest.env_for('http://example.com:8080/qwe') }

  it 'returns 500' do
    response = subject.call(request)

    expect(response[0]).to eq 500
  end
end

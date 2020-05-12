# frozen_string_literal: true

require 'spec_helper'

describe OmniAuth::Strategies::Timetree do
  subject do
    described_class.new({})
  end

  context 'client options' do
    it 'returns correct site' do
      expect(subject.options.client_options.site).to eq('https://timetreeapp.com')
    end

    it 'returns correct authorize_url' do
      expect(subject.options.client_options.authorize_url).to eq('/oauth/authorize')
    end

    it 'returns correct token_url' do
      expect(subject.options.client_options.token_url).to eq('/oauth/token')
    end
  end

  USER_API_RESPONSE = {
    "id": '12345',
    "type": 'user',
    "attributes": {
      "name": 'Your Name',
      "description": 'blah blah blah',
      "image_url": 'https://attachments.timetreeapp.com/path/to/image.png'
    }
  }.freeze

  context 'uid' do
    before do
      allow(subject).to receive(:raw_info) { USER_API_RESPONSE }
    end

    it 'returns correct uid' do
      expect(subject.uid).to eq('12345')
    end
  end

  context 'extra' do
    before do
      allow(subject).to receive(:raw_info) { USER_API_RESPONSE }
    end

    it 'returns correct extra block' do
      expect(subject.extra).to eq(raw_info: USER_API_RESPONSE)
    end
  end

  describe '#raw_info' do
    let(:access_token) { double('AccessToken', options: {}) }
    let(:response) { double('Response', parsed: { 'data' => USER_API_RESPONSE }) }

    before do
      allow(subject).to receive(:access_token) { access_token }
    end

    it 'returns raw_info' do
      expected_endpoint = 'https://timetreeapis.com/user'
      expected_headers = { headers: { 'Accept' => 'application/vnd.timetree.v1+json' } }
      allow(access_token).to receive(:get).with(expected_endpoint, expected_headers) { response }
      expect(subject.raw_info).to eq(USER_API_RESPONSE)
    end
  end

  describe '#callback_url' do
    it 'returns callback url' do
      allow(subject).to receive(:full_host) { 'http://localhost' }
      allow(subject).to receive(:script_name) { '/v1' }
      expect(subject.callback_url).to eq 'http://localhost/v1/auth/timetree/callback'
    end
  end
end

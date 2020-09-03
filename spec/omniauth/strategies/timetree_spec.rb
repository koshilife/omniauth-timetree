# frozen_string_literal: true

require 'spec_helper'

describe OmniAuth::Strategies::TimeTree do
  include OmniAuth::Test::StrategyTestCase
  include Rack::Test::Methods

  before do
    @logger = Logger.new STDOUT
    OmniAuth.config.logger = @logger

    @client_id = 'DUMMY_CLIENT_ID'
    @client_secret = 'DUMMY_CLIENT_SECRET'
    @options = {provider_ignores_state: true}
    @authorization_code = 'DUMMY_AUTH_CODE'
    @access_token = 'DUMMY_TOKEN'
  end

  let(:strategy) do
    [OmniAuth::Strategies::TimeTree, @client_id, @client_secret, @options]
  end

  let(:add_mock_exchange_token) do
    WebMock.enable!
    url = 'https://timetreeapp.com/oauth/token'
    body = {
      client_id: @client_id,
      client_secret: @client_secret,
      code: @authorization_code,
      grant_type: 'authorization_code',
      redirect_uri: 'http://example.org/auth/timetree/callback'
    }
    res_headers = {'Content-Type' => 'application/json'}
    stub_request(:post, url).with(body: URI.encode_www_form(body)).to_return(status: 200, body: dummy_token_response.to_json, headers: res_headers)
  end

  let(:dummy_token_response) do
    {
      access_token: @access_token,
      created_at: 1_558_583_443,
      token_type: 'Bearer'
    }
  end

  let(:add_mock_user_info) do
    WebMock.enable!
    url = 'https://timetreeapis.com/user'
    req_headers = {
      'Authorization' => "Bearer #{@access_token}",
      'Accept' => 'application/vnd.timetree.v1+json'
    }
    res_headers = {'Content-Type' => 'application/json'}
    stub_request(:get, url).with(headers: req_headers).to_return(status: 200, body: dummy_user_info.to_json, headers: res_headers)
  end

  let(:dummy_user_info) do
    {
      id: '12345',
      type: 'user',
      attributes: {
        name: 'Your Name',
        description: 'blah blah blah',
        image_url: 'https://attachments.timetreeapp.com/path/to/image.png'
      }
    }
  end

  context 'client options.' do
    let(:strategy) do
      args = [@client_id, @client_secret, @options]
      OmniAuth::Strategies::TimeTree.new(nil, *args)
    end
    it 'should return correct client_id.' do
      expect(strategy.options[:client_id]).to eq(@client_id)
    end
    it 'should return correct client_secret.' do
      expect(strategy.options[:client_secret]).to eq(@client_secret)
    end
    it 'should return correct site.' do
      expect(strategy.options.client_options.site).to eq('https://timetreeapp.com')
    end
  end

  context 'callback phase.' do
    it 'should get an access token and user information.' do
      add_mock_exchange_token
      add_mock_user_info
      post '/auth/timetree/callback', code: @authorization_code, state: 'state123'

      user_info = dummy_user_info
      actual_auth = last_request.env['omniauth.auth'].to_hash
      expected_auth = {
        'provider' => 'timetree',
        'uid' => user_info[:id],
        'info' => {'name' => nil},
        'credentials' => {'token' => @access_token, 'expires' => false},
        'extra' => {
          'raw_info' => JSON.parse(user_info.to_json)
        }
      }
      expect(expected_auth).to eq(actual_auth)
    end
  end
end

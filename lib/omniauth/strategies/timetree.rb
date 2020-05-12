# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Timetree < OmniAuth::Strategies::OAuth2
      option :name, 'timetree'
      option :client_options, site: 'https://timetreeapp.com',
                              authorize_url: '/oauth/authorize',
                              token_url: '/oauth/token'

      uid { raw_info[:id] }

      extra do
        { raw_info: raw_info }
      end

      def raw_info
        endpoint = 'https://timetreeapis.com/user'
        options = { headers: { 'Accept' => 'application/vnd.timetree.v1+json' } }
        @raw_info ||= access_token.get(endpoint, options).parsed['data'] || {}
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

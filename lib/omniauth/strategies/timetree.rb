# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Timetree < OmniAuth::Strategies::OAuth2
      option :name, 'timetree'
      option :client_options, :site => 'https://timetreeapp.com'

      uid { raw_info[:id] }

      extra do
        {:raw_info => raw_info}
      end

      def raw_info
        return @raw_info unless @raw_info.nil?

        endpoint = 'https://timetreeapis.com/user'
        options = {:headers => {'Accept' => 'application/vnd.timetree.v1+json'}}
        res = access_token.get(endpoint, options)
        parsed_body = JSON.parse(res.body, :symbolize_names => true)
        @raw_info = parsed_body[:data] || {}
      end

      def callback_url
        full_host + script_name + callback_path
      end
    end
  end
end

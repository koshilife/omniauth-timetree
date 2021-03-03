# frozen_string_literal: true

require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class TimeTree < OmniAuth::Strategies::OAuth2
      option :name, 'timetree'
      option :client_options, site: 'https://timetreeapp.com'

      uid { extract_uid }

      extra do
        {raw_info: raw_info}
      end

    private

      def raw_info
        return @raw_info if defined?(@raw_info)

        endpoint = 'https://timetreeapis.com/user'
        options = {headers: {'Accept' => 'application/vnd.timetree.v1+json'}}
        @raw_info = access_token.get(endpoint, options).parsed
      end

      def extract_uid
        raw_info.dig('data', 'id')
      end

      def callback_url
        full_host + callback_path
      end
    end
  end
end

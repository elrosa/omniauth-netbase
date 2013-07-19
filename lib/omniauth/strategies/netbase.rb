require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Netbase <  OmniAuth::Strategies::OAuth2

      option :name, "netbase"
      option :client_options, {
          :site => "https://api.netbase.com/cb/insight-api/2",
          :authorize_url => 'https://api.netbase.com/cb/oauth/authorize',
          :token_url => 'https://api.netbase.com/cb/oauth/token'
      }

      option :token_params, {
          :parse => :json
      }

      uid { info['userId'] }

      info do
        raw_info
      end

      extra do
        {'raw_info' => raw_info.merge(access_token.params)}
      end

      def raw_info
        @raw_info ||= access_token.get('/profile').parsed
      end

    end
  end
end
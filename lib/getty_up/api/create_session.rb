require 'getty_up/api/util'
require 'rest_client'

module GettyUp
  module API
    module CreateSession
      include GettyUp::API::Util

      ENDPOINT = "https://connect.gettyimages.com/v1/session/CreateSession"

      def create_session
        request = {
          :RequestHeader => {
            :Token => ""
          },
          :CreateSessionRequestBody =>
          {
            :SystemId => @system_id,
            :SystemPassword => @system_password,
            :UserName => @api_username,
            :UserPassword => @api_password
          }
        }

        puts request
        # response = post_json(request, ENDPOINT)
        response = RestClient.post ENDPOINT, request.to_json, :content_type => :json, :accept => :json

        puts response
        if response.code == '200'
          @token = response[0]["CreateSessionResult"]["Token"]
          @status = response[0]["ResponseHeader"]["Status"]
          @secure_token = response[0]["CreateSessionResult"]["SecureToken"]
          @token_duration = response[0]["CreateSessionResult"]["TokenDurationMinutes"]
          @token_expiration = @token_duration.minutes.from_now
        end
      end

      def session_valid?
        @token_expiration.present? && @token_expiration > Time.now
      end

    end
  end
end

require 'rest_client'

module GettyUp
  module API
    module Util
      def post_json(request, endpoint, debug = false)
      
       if debug
         puts  '--- Request to Getty --'
         puts  request
       end

       response = RestClient.post endpoint, request.to_json, :content_type => :json, :accept => :json

       if debug
          puts  '--- Response from Getty --'
          puts  response
       end
      
       JSON.parse(response)

      end

    end
  end
end

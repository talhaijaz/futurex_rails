module FutureXRails
  class AccessToken
    attr_reader :config, :login_url, :body, :client

    def initialize(body, client = FutureXRails.client)
      @config = FutureXRails.config
      @token_url = 'https://futurex.nelc.gov.sa/oauth/token'
      @body = body
      @client = client
    end

    def fetch
      client.post_api_data(token_url, body)
    end
  end
end

require 'rest-client'

module FutureXRails

  class << self
    attr_accessor :client

    def client
      @client ||= Client.new
    end
  end

  class Client
    def initialize
    end

    def post_api_data(url, body, access_token = nil)
      begin
        headers = {Authorization: "Bearer #{access_token}"} if access_token.present?
        response = RestClient.post(url, body)
        OpenStruct.new({ code: response.code, body: JSON(response.body) })
      rescue StandardError => e
        handle_exception(e)
      end
    end

    def get_api_data(url, access_token)
      begin
        headers = {Authorization: "Bearer #{access_token}"}
        response = RestClient.get(url, headers)
        OpenStruct.new({ code: response.code, body: JSON(response.body) })
      rescue StandardError => e
        handle_exception(e)
      end
    end

    def handle_exception(exception)
      OpenStruct.new({ code: exception.http_code, body: exception.http_body })
    end

    def format_response(entity_data)
      body = entity_data.body
      {code: entity_data.code, body: body}
    end
  end
end

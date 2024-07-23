require 'futurex_rails/version'
require 'futurex_rails/client'
require 'futurex_rails/access_token'
require 'futurex_rails/fetch_or_create_data'

module FutureXRails
  class Error < StandardError
    def initialize(msg)
      # extract Rest Exception message if present
      if msg.include?('[RestException:')
        msg = msg[/\[RestException:(.*?)\]/, 1]&.strip
      end

      super(msg)
    end
  end
end
module EvilSystems
  module RemoteChrome
    # @return [String, nil]
    def self.url
      ENV["CHROME_URL"]
    end

    # Current port
    # @return Integer
    def self.port
      URI.parse(url).yield_self { |uri| uri.port }
    end

    # Current host
    # @return [String, nil]
    def self.host
      URI.parse(url).yield_self { |uri| uri.host } if url
    end

    # Returns a hash with a :url key / value if a remote chrome url is found.
    # @return [Hash{:url => String, nil}]
    #
    def self.options
      # Check whether the remote chrome is running and configure the Capybara
      # driver for it.
      connected? ? {url: url} : {}
    end

    # Whether or not the socket could be connected
    # @return [Boolean]
    def self.connected?
      if url.nil?
        false
      else
        Socket.tcp(host, port, connect_timeout: 1).close
        true
      end
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, SocketError
      false
    end
  end
end

module EvilSystems
  module RemoteChrome
    URL = ENV["CHROME_URL"]
    HOST, PORT =
      if URL
        URI.parse(URL).yield_self do |uri|
          [uri.host, uri.port]
        end
      end

    def self.options
      # Check whether the remote chrome is running and configure the Capybara
      # driver for it.
      remote_chrome =
        begin
          if URL.nil?
            false
          else
            Socket.tcp(HOST, PORT, connect_timeout: 1).close
            true
          end
        rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH, SocketError
          false
        end

      remote_chrome ? {url: REMOTE_CHROME_URL} : {}
    end
  end
end


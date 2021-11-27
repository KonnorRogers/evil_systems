# frozen_string_literal: true

module EvilSystems
  # Capybara settings (not covered by Rails system tests)
  module Settings
    # Finds the current app host via ENV["APP_HOST"], `hostname`, or defaults to "0.0.0.0"
    # @return [String]
    def self.app_host
      "http://#{ENV.fetch("APP_HOST", "0.0.0.0")}"
    end

    # Finds the current cookie domain
    # @return [String]
    def self.cookie_domain
      URI.parse(app_host).host.then do |host|
        # If host is a top-level domain
        next host unless host.include?(".")

        ".#{host}"
      end
    end

    # The setup to be run prior to the test suite
    def self.initial_setup
      prepend_session_to_capybara

      ::Capybara.app_host = app_host

      # Make server listening on all hosts
      ::Capybara.server_host = "0.0.0.0"

      # Silence puma
      ::Capybara.server = :puma, {Silent: true}

      # Don't wait too long in `have_xyz` matchers
      ::Capybara.default_max_wait_time = 2

      # Normalizes whitespaces when using `has_text?` and similar matchers
      ::Capybara.default_normalize_ws = true

      # Where to store artifacts (e.g. screenshots, downloaded files, etc.)
      ::Capybara.save_path = ENV.fetch("CAPYBARA_ARTIFACTS", "./tmp/capybara")

      # Disable animations in Capybara by default
      ::Capybara.disable_animation = ENV.fetch("DISABLE_ANIMATION", "true") == "true"
    end

    private_class_method def self.prepend_session_to_capybara
      ::Capybara.singleton_class.prepend(Module.new do
        attr_accessor :last_used_session

        def using_session(name, &block)
          self.last_used_session = name
          super
        ensure
          self.last_used_session = nil
        end
      end)
    end
  end
end

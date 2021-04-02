# frozen_string_literal: true

require "capybara"
module EvilSystems
  # Capybara settings (not covered by Rails system tests)
  module CapybaraSetup
    # Use a hostname accessible from the outside world
    # NOTE: Rails overrides Capybara.app_host in Rails <6.1, so we have
    # to store it differently
    CAPYBARA_APP_HOST = "http://#{ENV.fetch("APP_HOST", `hostname`.strip&.downcase || "0.0.0.0")}"
    Capybara.app_host = CAPYBARA_APP_HOST

    # Which domain to use when setting cookies directly in tests.
    CAPYBARA_COOKIE_DOMAIN = URI.parse(CAPYBARA_APP_HOST).host.then do |host|
      # If host is a top-level domain
      next host unless host.include?(".")

      ".#{host}"
    end

    def self.setup
      # Make server listening on all hosts
      Capybara.server_host = "0.0.0.0"
      # Don't wait too long in `have_xyz` matchers
      Capybara.default_max_wait_time = 2

      # Normalizes whitespaces when using `has_text?` and similar matchers
      Capybara.default_normalize_ws = true

      # Where to store artifacts (e.g. screenshots, downloaded files, etc.)
      Capybara.save_path = ENV.fetch("CAPYBARA_ARTIFACTS", "./tmp/capybara")

      prepend_session_to_capybara
    end

    private_class_method def self.prepend_session_to_capybara
      Capybara.singleton_class.prepend(Module.new do
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

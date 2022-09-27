# frozen_string_literal: true

module EvilSystems
  # Cuprite is a modern Capybara driver which uses Chrome CDP API
  # instead of Selenium & co.
  # See https://github.com/rubycdp/cuprite
  module RegisterCuprite
    # Registers the Cuprite driver. Can be used via:
    # driven_by :evil_cuprite, using: :chrome, screen_size: [1400, 1400]
    # The initial setup prior to the class ApplicationSystemTestCase, runs before the entire test suite.
    # @return [void]
    def self.initial_setup(driver_options: {})
      begin
        require "capybara"
        require "capybara/cuprite"
      rescue LoadError
        return
      end

      begin
        process_timeout = Integer(ENV.fetch("PROCESS_TIMEOUT", 5))
      rescue
        process_timeout = 5
      end

      remote_options = RemoteChrome.options

      ::Capybara.register_driver(:evil_cuprite) do |app|
        ::Capybara::Cuprite::Driver.new(
          app,
          **{
            window_size: [1200, 800],
            browser_options: RemoteChrome.connected? ? {"no-sandbox" => nil} : {},
            headless: ENV.fetch("CI", "true") == "true",
            process_timeout: process_timeout,
            slowmo: ENV.fetch("SLOWMO", 0).to_f,
            inspector: true
          }.merge(remote_options).merge(driver_options)
        )
      end
    end
  end
end

Capybara.default_driver = Capybara.javascript_driver = :evil_cuprite

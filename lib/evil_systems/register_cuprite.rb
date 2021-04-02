# frozen_string_literal: true

# Cuprite is a modern Capybara driver which uses Chrome CDP API
# instead of Selenium & co.
# See https://github.com/rubycdp/cuprite

module EvilSystems
  module RegisterCuprite
    def self.setup
      require "capybara/cuprite"
      Capybara.register_driver(:cuprite) do |app|
        Capybara::Cuprite::Driver.new(
          app,
          **{
            window_size: [1200, 800],
            browser_options: {"no-sandbox" => nil},
            inspector: true
          }.merge(remote_options)
        )
    end
  end
end

Capybara.default_driver = Capybara.javascript_driver = :cuprite

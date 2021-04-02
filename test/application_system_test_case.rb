require "test_helper"
# require "evil_systems/cuprite_setup"

require "capybara/cuprite"
require "evil_systems/capybara_setup"
require "evil_systems/cuprite_setup"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]

  def setup
    CapybaraSetup.setup
  end
end

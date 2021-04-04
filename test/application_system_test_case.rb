require "test_helper"

require "capybara"
require "capybara/cuprite"
require "evil_systems"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :cuprite, using: :chrome, screen_size: [1400, 1400]

  include EvilSystems::Helpers

  EvilSystems.initial_setup

  # def setup
  #   EvilSystems.setup
  # end

  # def teardown
  #   EvilSystems.teardown
  # end
end

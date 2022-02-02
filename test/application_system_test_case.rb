require "test_helper"

require "capybara"
require "capybara/cuprite"
require "evil_systems"

EvilSystems.initial_setup(skip_task: true)

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :evil_cuprite

  include EvilSystems::Helpers
end

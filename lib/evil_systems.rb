require "evil_systems/version"

module EvilSystems
end

require "evil_systems/capybara_setup"
require "evil_systems/cuprite_setup" if defined?(Cuprite)
require "evil_systems/engine" if defined?(Rails)

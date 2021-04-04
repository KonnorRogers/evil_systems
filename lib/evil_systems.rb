require "zeitwerk"
loader = Zeitwerk::Loader.for_gem
loader.setup

# EvilMartians like setup for Minitest
module EvilSystems
  # To be called before module +ApplicationSystemTest+
  # @return void
  def self.initial_setup
    Settings.initial_setup
    RegisterCuprite.initial_setup
  end

  # To be called in the +setup+ hook of +ApplicationSystemTest+
  # @return void
  def self.setup
  end

  # To be called in the +teardown+ hook of +ApplicationSystemTest+
  # @return void
  def self.teardown
  end
end

require "evil_systems/engine" if defined?(Rails)

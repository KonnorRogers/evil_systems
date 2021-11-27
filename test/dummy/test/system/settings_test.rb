require "application_system_test_case"

class SettingsTest < ApplicationSystemTestCase
  test "capybara app host is set via ENV['APP_HOST']" do
    old_app_host = ENV["APP_HOST"]
    ENV["APP_HOST"] = "konnor.com"

    assert_equal ::EvilSystems::Settings.app_host, "http://konnor.com"
    assert_equal ::EvilSystems::Settings.cookie_domain, ".konnor.com"

    ENV["APP_HOST"] = old_app_host
  end

  test "When no hostname or app_host found" do
    old_app_host = ENV["APP_HOST"]
    ENV.delete("APP_HOST")

    assert_equal ::EvilSystems::Settings.app_host, "http://0.0.0.0"
    assert_equal ::EvilSystems::Settings.cookie_domain, ".0.0.0.0"

    ENV["APP_HOST"] = old_app_host
  end
end

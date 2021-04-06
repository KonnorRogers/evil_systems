require "application_system_test_case"

class RemoteChromeTest < ApplicationSystemTestCase
  def setup
    @original_url = ENV["CHROME_URL"]
  end

  def teardown
    ENV["CHROME_URL"] = @original_url
  end

  test "Remote chrome url set via ENV variable" do
    ENV["CHROME_URL"] = "http://0.0.0.0:3459"

    assert_equal ::EvilSystems::RemoteChrome.url, "http://0.0.0.0:3459"
    assert_equal ::EvilSystems::RemoteChrome.port, 3459
    assert_equal ::EvilSystems::RemoteChrome.host, "0.0.0.0"

    ::EvilSystems::RemoteChrome.stub :connected?, true do
      assert_equal ::EvilSystems::RemoteChrome.options, {url: ::EvilSystems::RemoteChrome.url}
    end
  end
end

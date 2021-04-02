require "application_system_test_case"

class CapybaraSetupsTest < ApplicationSystemTestCase
   test "capybara app host is properly set" do
     visit root_url

     assert CAPYBARA_APP_HOST = "http://0.0.0.0"
     assert CAPYBARA_APP_HOST = "http://0.0.0.0"
   end
end

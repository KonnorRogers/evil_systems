require "application_system_test_case"

class HelpersTest < ApplicationSystemTestCase
  test "helpers should be included" do
    assert ::ApplicationSystemTestCase.include?(ActionView::RecordIdentifier)
    assert ::ApplicationSystemTestCase.include?(::EvilSystems::CupriteHelpers)
    assert ::ApplicationSystemTestCase.include?(::EvilSystems::Helpers)
    assert ::ApplicationSystemTestCase.include?(::EvilSystems::SessionHelpers)

    refute ::ActionDispatch::SystemTestCase.include?(ActionView::RecordIdentifier)
    refute ::ActionDispatch::SystemTestCase.include?(::EvilSystems::CupriteHelpers)
    refute ::ActionDispatch::SystemTestCase.include?(::EvilSystems::Helpers)
    refute ::ActionDispatch::SystemTestCase.include?(::EvilSystems::SessionHelpers)
  end

  test "dom id should return with a # in front of it" do
    assert dom_id(Article.first).starts_with?("#")
  end

  test "Should take a screenshot" do
    screen_shot_path = ::Rails.root.join("tmp/capybara/screenshots/1_test_Should_take_a_screenshot.png")
    FileUtils.rm screen_shot_path if File.exist?(screen_shot_path)
    take_screenshot
    assert File.exist?(screen_shot_path)
  end
end

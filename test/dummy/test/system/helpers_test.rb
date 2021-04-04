require "application_system_test_case"

class HelpersTest < ApplicationSystemTestCase
  test "helpers should be included" do
    assert ::ApplicationSystemTestCase.include?(ActionView::RecordIdentifier)
    assert ::ApplicationSystemTestCase.include?(::EvilSystems::CupriteHelpers)
    assert ::ApplicationSystemTestCase.include?(::EvilSystems::Helpers)

    refute ::ActionDispatch::SystemTestCase.include?(ActionView::RecordIdentifier)
    refute ::ActionDispatch::SystemTestCase.include?(::EvilSystems::CupriteHelpers)
    refute ::ActionDispatch::SystemTestCase.include?(::EvilSystems::Helpers)
  end
end

# frozen_string_literal: true

module EvilSystems
  # Helpers to make life easier
  module Helpers
    include ActionView::RecordIdentifier if defined? ::Rails
    include CupriteHelpers if defined? ::Capybara::Cuprite
    include SessionHelpers

    # Use our `Capybara.save_path` to store screenshots with other capybara artifacts
    # (Rails screenshots path is not configurable https://github.com/rails/rails/blob/49baf092439fc74fc3377b12e3334c3dd9d0752f/actionpack/lib/action_dispatch/system_testing/test_helpers/screenshot_helper.rb#L79)
    # @return [String]
    def absolute_image_path
      return ::Rails.root.join("#{::Capybara.save_path}/screenshots/#{image_name}.png") if defined? ::Rails

      File.join("#{::Capybara.save_path}/screenshots/#{image_name}.png")
    end

    # Use relative path in screenshot message to make it clickable in VS Code when running in Docker
    # @return [String]
    def image_path
      return absolute_image_path.relative_path_from(::Rails.root).to_s if defined? ::Rails

      absolute_image_path.relative_path_from(Dir.pwd)
    end

    # Make failure screenshots compatible with multi-session setup
    # @return void
    def take_screenshot
      return super unless ::Capybara.respond_to?(:last_used_session) && ::Capybara.last_used_session

      ::Capybara.using_session(::Capybara.last_used_session) { super }
    end

    # Convert dom_id to a selector.
    # @example
    #   dom_id(Facility.first)
    #   # => "#facility-1"
    # @return [String]
    def dom_id(*args)
      "##{super}"
    end
  end
end

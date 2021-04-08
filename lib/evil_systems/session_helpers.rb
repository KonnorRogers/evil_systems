module EvilSystems
  # Capybara Sessions are limited, lets add some extra helpers.
  module SessionHelpers
    # Convencience method for session names.
    def within_session(name_or_session, &block)
      ::Capybara.using_session(name_or_session, &block)
    end
  end
end

# Add shortcuts for cuprite-specific debugging helpers
module EvilSystems
  module CupriteHelpers
    # Pauses the current driver
    # @return [nil]
    def pause
      page.driver.pause
    end

    # Opens a debug session via Pry if defined, else uses Irb.
    def debug(binding = nil)
      $stdout.puts "🔎 Open Chrome inspector at http://localhost:3333"
      if binding
        return binding.pry if defined?(Pry)

        return binding.irb
      end

      page.driver.pause
    end
  end
end

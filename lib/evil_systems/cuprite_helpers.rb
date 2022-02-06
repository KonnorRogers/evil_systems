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

    # Convenience method to access the drivers `wait_for_network_idle`
    # @see https://github.com/rubycdp/cuprite/blob/47d8949f30dea3d97dba70d8643abce861e0d652/README.md#network-traffic
    def wait_for_network_idle!
      page.driver.wait_for_network_idle
    end
  end
end

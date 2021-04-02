# Add shortcuts for cuprite-specific debugging helpers
module CupriteHelpers
  def pause
    page.driver.pause
  end

  def debug(binding = nil)
    $stdout.puts "🔎 Open Chrome inspector at http://localhost:3333"
    if binding
      return binding.pry if defined?(Pry)

      return binding.irb
    end

    page.driver.pause
  end
end

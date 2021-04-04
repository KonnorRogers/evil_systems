# frozen_string_literal: true

module EvilSystems
  module PrecompileAssets
    # Precompile assets before running tests to avoid timeouts.
    # Do not precompile if webpack-dev-server is running (NOTE: MUST be launched with RAILS_ENV=test)
    # @param task [String, nil] ("assets:precompile") - the precompile task to run
    # @param silent [Boolean] (true) - silence build output and only show asset compilation and time spent compiling.
    def self.initial_setup(task: "assets:precompile", silent: true)
      $stdout.puts "\n🐢  Precompiling assets.\n"
      original_stdout = $stdout.clone
      start = Time.current
      begin
        # Silence output
        $stdout.reopen(File.new("/dev/null", "w")) if silent == true
        # next 3 lines to compile assets before running our test suite
        require "rake"
        Rails.application.load_tasks
        Rake::Task[task].invoke if task
      ensure
        $stdout.reopen(original_stdout) if silent == true
        $stdout.puts "Finished in #{(Time.current - start).round(2)} seconds"
      end
    end
  end
end

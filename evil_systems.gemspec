require_relative "lib/evil_systems/version"

Gem::Specification.new do |spec|
  spec.name = "evil_systems"
  spec.version = EvilSystems::VERSION
  spec.authors = ["ParamagicDev"]
  spec.email = ["konnor5456@gmail.com"]
  spec.homepage = "https://github.com/paramagicdev/evil_systems"
  spec.summary = "Fully integrated setup based on EvilMartians system of a test"
  spec.license = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  spec.metadata["allowed_push_host"] = "https://github.com/paramagicdev/evil_systems"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/paramagicdev/evil_systems"
  spec.metadata["changelog_uri"] = "https://github.com/paramagicdev/evil_systems/CHANGELOG.md"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md", "CHANGELOG.md"]

  spec.add_dependency "zeitwerk", ">= 2"
  spec.add_dependency "capybara"

  spec.add_development_dependency "standardrb", ">= 1.0.0"
end

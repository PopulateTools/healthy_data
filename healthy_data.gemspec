require_relative "lib/healthy_data/version"

Gem::Specification.new do |spec|
  spec.name        = "healthy_data"
  spec.version     = HealthyData::VERSION
  spec.authors     = ["Víctor Martín"]
  spec.email       = ["victor@populate.tools"]
  spec.homepage    = "https://github.com/PopulateTools/healthy_data"
  spec.summary     = ""
  spec.description = ""
  spec.license     = "MIT"


  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage

  spec.files         = Dir["*.{md,txt}", "{app,config,lib,vendor,bin}/**/*"]
  spec.test_files    = Dir["spec/**/*"]
  spec.executables   = ['healthy-data']
  spec.require_paths = "lib"

  spec.add_dependency "rails", "~> 6.1.3", ">= 6.1.3.1"
  spec.add_development_dependency 'pry', '>= 0.14.1'
  spec.add_development_dependency 'rspec-rails', '>= 5.0.1'
  spec.add_development_dependency 'factory_bot_rails', '>= 6.1.0'
  spec.add_development_dependency 'database_cleaner', '>= 2.0.1'
end

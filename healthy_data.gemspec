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

  spec.files         = Dir["*.{md,txt}", "{app,config,lib,vendor}/**/*"]
  spec.require_path  = "lib"

  spec.add_dependency "rails", "~> 6.1.3", ">= 6.1.3.1"
  spec.add_development_dependency 'pry', '~> 0.14.1', '>= 0.14.1'
end

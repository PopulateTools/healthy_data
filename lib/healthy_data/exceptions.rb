module HealthyData
  class Error < StandardError; end

  # Config file related exceptions
  class ConfigError < Error; end
  class MissingArgsError < ConfigError; end
  class InvalidRuleNameError < ConfigError; end
end

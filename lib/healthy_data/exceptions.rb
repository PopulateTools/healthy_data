module HealthyData
  class Error < StandardError; end

  # Config file related exceptions
  class ConfigError < Error; end
  class MissingConfigFileError < ConfigError; end
  class MissingDatabaseConfigFileError < ConfigError; end
  class MissingRulesError < ConfigError; end
  class InvalidRuleNameError < ConfigError; end
end

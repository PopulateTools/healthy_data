module HealthyData
  module Setup

    attr_accessor :item_rules_file_location, :item_rules

    def setup
      yield self
      set_rules
    end

    def set_rules
      if item_rules_file_location && File.exists?(item_rules_file_location)
        rules = (YAML.load_file(item_rules_file_location).presence||{})
        validate_rules!(rules)
        self.item_rules = rules
      else
        raise(HealthyData::MissingConfigFileError)
      end
    end

    private

    def validate_rules!(rule_configs)
      rule_configs.each do |rule_config|
        rule_config['rules'].each do |rule|
          raise(HealthyData::InvalidRuleNameError) unless rule_exists?(rule['name'])
        end
      end
    end

    def rule_exists?(rule_name)
      return false if rule_name.blank?

      base_namespace = ['HealthyData', 'Items', 'Rules']
      base_namespace << rule_name.camelize

      base_namespace.join('::').safe_constantize.present?
    end

  end
end

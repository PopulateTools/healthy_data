module HealthyData
  module Setup

    attr_accessor :item_rules_file_location, :item_rules

    def setup
      yield self
      set_rules
    end

    def set_rules
      if item_rules_file_location && File.exists?(item_rules_file_location)
        self.item_rules = YAML.load_file(item_rules_file_location)
      end
    end

  end
end

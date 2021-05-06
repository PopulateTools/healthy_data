module HealthyData
  module Items
    class Checker
      attr_reader :item, :model_name

      def initialize item, model_name
        @item       = item
        @model_name = model_name
      end

      def call
        return false if rule_config.blank?
        ActiveRecord::Base.transaction do
          iterate_rule_set
        end
      end

      private

      def iterate_rule_set
        rule_set.each do |rule|
          rule_class = rule_class_for(rule['name'])
          rule_class.new(item: item, model_name: model_name, args: rule.fetch('args', {})).call
        end
      end

      def rule_class_for rule_name
        base = ['HealthyData', 'Items', 'Rules']
        base << rule_name.camelize

        base.join('::').safe_constantize
      end

      def rule_set
        @rule_set ||= rule_config.fetch('rules', [])
      end

      def rule_config
        @rule_config ||= HealthyData.item_rules_for(model_name)
      end

    end
  end
end

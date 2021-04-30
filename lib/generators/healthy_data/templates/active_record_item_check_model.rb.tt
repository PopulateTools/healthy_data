class HealthyData::ItemCheck < ApplicationRecord
  self.table_name = "healthy_data_item_checks"

  belongs_to :checkable, polymorphic: true

  def recheck
    rule_class.new(item: checkable, model_name: checkable_type, args: args).call
  end

  private

  def rule_class
    base_namespace = ['HealthyData', 'ItemRules']
    base_namespace << rule.camelize
    base_namespace.join('::').safe_constantize
  end
end

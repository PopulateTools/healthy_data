require 'healthy_data/setup'
require 'healthy_data/exceptions'

require "healthy_data/version"
require "healthy_data/engine"

require "healthy_data/model"
require "healthy_data/items"

module HealthyData
  extend Setup
  extend self

  ActiveSupport.on_load(:active_record) do
    extend HealthyData::Model
  end

  def run model_name
    raise HealthyData::MissingRulesError if item_rules_for(model_name).blank?
    Items::Processor.new(item_rules_for(model_name)).call
  end

  def item_rules_for model_name
    @item_rules.find{|model_rule_config| model_rule_config['model_name'] == model_name }
  end

  def available_rules
    @item_rules.map{|model_rule_config| model_rule_config['model_name']}
  end
end

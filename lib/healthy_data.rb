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

  def item_rules_for model_name
    @item_rules.find{|rule_config| rule_config['model_name'] == model_name }
  end
end

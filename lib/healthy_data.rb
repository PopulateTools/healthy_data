require "healthy_data/version"
require "healthy_data/engine"

require "healthy_data/model"
require "healthy_data/item_rules"

module HealthyData
  ActiveSupport.on_load(:active_record) do
    extend HealthyData::Model
  end
end

module HealthyData
  module Items
    class Processor
      attr_reader :model_rule_config

      def initialize model_rule_config
        @model_rule_config = model_rule_config
      end

      def call
        items.each do |item|
          Checker.new(item, model_rule_config['model_name']).call
        end
      end

      private

      def items
        @items ||= if model_class
          model_class.find_by_sql(model_rule_config['sql_query'])
        else
          sql_items.map{|result| struct.new(*result.values) }
        end
      end

      def sql_items
        @sql_items ||= ActiveRecord::Base.connection.execute(model_rule_config['sql_query'])
      end

      def struct
        @struct ||= Struct.new *sql_items.first.symbolize_keys.keys
      end

      def model_class
        model_rule_config['model_name'].safe_constantize
      end

    end
  end
end

module HealthyData
  module Items
    class Processor
      attr_reader :rule_config

      def initialize rule_config
        @rule_config = rule_config
      end

      def call
        items.each do |item|
          Checker.new(item, rule_config.fetch('model_name')).call
        end
      end

      private

      def items
        @items ||= sql_items.map{|result| struct.new(*result.values) }
      end

      def sql_items
        @sql_items ||= ActiveRecord::Base.connection.execute(rule_config['sql_query'])
      end

      def struct
        @struct ||= Struct.new *sql_items.first.symbolize_keys.keys
      end

    end
  end
end

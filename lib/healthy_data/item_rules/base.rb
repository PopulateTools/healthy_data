module HealthyData
  module ItemRules
    class Base
      attr_reader :item, :model_name, :args

      def initialize item:, model_name:, args:
        @item       = item
        @model_name = model_name
        @args       = args.with_indifferent_access
      end

      def call
        if check_passes?
          mark_as_solved
        else
          create_or_update
        end
      end

      private

      def create_or_update
        integrity_item = HealthyData::ItemCheck.find_or_create_by(find_params)
        integrity_item.update_columns(checked_at: Time.now, result: result, args: args)
      end

      def mark_as_solved
        HealthyData::ItemCheck.find_by(find_params)&.update_column(:solved, true)
      end

      def find_params
        { checkable_id: item.id, checkable_type: model_name, rule: rule_name, solved: false }
      end

      def rule_name
        self.class.name.split('::').last.underscore
      end

      # attribute_value, attribute_name, etc.
      # - *_name: content in yml
      # - *_value: value of the attribute with the same name for the item
      # i.e.: attribute_name is "amount", attribute_value is the value of the column "amount" in item.
      def method_missing method_name,*method_args, &method_block
        if method_name.end_with?('_name') || method_name.end_with?('_names')
          attribute = method_name.to_s.gsub(/_name(s)?$/,'')
          args.fetch(attribute)
        elsif method_name.end_with?('_value')
          attribute = method_name.to_s.gsub('_value','')
          attribute_name = send("#{attribute}_name")
          item.send attribute_name
        elsif method_name.end_with?('_values')
          attribute = method_name.to_s.gsub('_values','')
          attribute_names = send("#{attribute}_names")
          attribute_names.map{|attribute_name| item.send(attribute_name) }
        else
          super
        end
      end

      def attribute_value
        item.send(args.fetch(:attribute))
      end

      def attribute_value
        item.send(args.fetch(:attribute))
      end

      def check_passes?
        raise NotImplementedError, 'Each subclass must define its own #check_passes? method'
      end

      def result
        raise NotImplementedError, 'Each subclass must define its own #result method'
      end

    end
  end
end

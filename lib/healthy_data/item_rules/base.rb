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

      def check_passes?
        raise NotImplementedError, 'Each subclass must define its own #check_passes? method'
      end

      def result
        raise NotImplementedError, 'Each subclass must define its own #result method'
      end

    end
  end
end

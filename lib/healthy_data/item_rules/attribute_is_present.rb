module HealthyData
  module ItemRules
    class AttributeIsPresent < Base

      private

      def check_passes?
        attribute.present?
      end

      def result
        "#{args[:attribute]} is missing in #{model_name}##{item.id}"
      end

      def attribute
        item.send(args[:attribute])
      end

    end
  end
end

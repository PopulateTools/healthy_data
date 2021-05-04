module HealthyData
  module ItemRules
    class AttributeIsPresent < Base

      private

      def check_passes?
        attribute_value.present?
      end

      def result
        "#{attribute_name} is missing"
      end

    end
  end
end

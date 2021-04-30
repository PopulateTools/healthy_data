module HealthyData
  module ItemRules
    class AttributeIsPresent < Base

      private

      def check_passes?
        attribute.present?
      end

      def result
        "#{args.fetch(:attribute)} is missing"
      end

    end
  end
end

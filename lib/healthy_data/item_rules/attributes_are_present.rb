module HealthyData
  module ItemRules
    class AttributesArePresent < Base

      private

      def check_passes?
        attributes_values.all?(&:present?)
      end

      def result
        attributes_names.each_with_object([]) do |attribute_name, output|
          next if item.send(attribute_name).present?
          output << "#{attribute_name} is missing"
        end.join('. ')
      end

    end
  end
end

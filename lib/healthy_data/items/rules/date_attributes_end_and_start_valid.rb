module HealthyData
  module Items
    module Rules
      class DateAttributesEndAndStartValid < Base

        private

        def check_passes?
          return true if start_date_attribute_value.blank? || end_date_attribute_value.blank?

          start_date_attribute_value < end_date_attribute_value
        end

        def result
          "#{end_date_attribute_name} (#{end_date_attribute_value}) is before #{end_date_attribute_name} (#{end_date_attribute_value})"
        end

      end
    end
  end
end

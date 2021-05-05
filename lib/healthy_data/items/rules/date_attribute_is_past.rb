module HealthyData
  module Items
    module Rules
      class DateAttributeIsPast < Base

        private

        def check_passes?
          return true if attribute_value.blank?
          convert_to_date(attribute_value) < Time.now
        end

        def result
          "#{attribute_name} (#{attribute_value}) is in the future"
        end

      end
    end
  end
end

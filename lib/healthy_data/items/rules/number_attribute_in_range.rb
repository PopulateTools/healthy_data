module HealthyData
  module Items
    module Rules
      class NumberAttributeInRange < Base

        private

        def check_passes?
          return true if attribute_value.blank?

          attribute_value.between?(min_amount_name, max_amount_name)
        end

        def result
          "#{attribute_name} (#{attribute_value}) is not within #{min_amount_name} and #{max_amount_name}"
        end

      end
    end
  end
end

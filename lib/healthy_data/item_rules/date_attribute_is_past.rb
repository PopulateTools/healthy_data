module HealthyData
  module ItemRules
    class DateAttributeIsPast < Base

      private

      def check_passes?
        return true if attribute.blank?
        attribute < Time.now
      end

      def result
        "#{args[:attribute]} (#{attribute}) is in the future"
      end

    end
  end
end

module HealthyData
  module ItemRules
    class NumberAttributeInRange < Base

      private

      def check_passes?
        return false if attribute.blank?

        attribute.between?(min_amount, max_amount)
      end

      def result
        "#{args.fetch(:attribute)} (#{attribute}) is not within #{min_amount} and #{max_amount}"
      end

      def min_amount
        args.fetch(:min_amount)
      end

      def max_amount
        args.fetch(:max_amount)
      end

    end
  end
end

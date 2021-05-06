module HealthyData
  module Model

    def has_healthy_data
      class_eval do
        has_many :healthy_data_item_checks, class_name: "HealthyData::ItemCheck", as: :checkable, dependent: :destroy
      end
    end

  end
end

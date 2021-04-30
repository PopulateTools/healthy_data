FactoryBot.define do
  factory :item do
    amount { 2 }
    start_date  { Date.parse("2020/02/10") }
    end_date  { Date.parse("2020/05/12") }
  end
end

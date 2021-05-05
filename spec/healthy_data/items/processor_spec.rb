require 'rails_helper'
require 'fileutils'

RSpec.describe HealthyData::Items::Processor do
  before(:all) do
    HealthyData.setup do |config|
      config.item_rules_file_location = Rails.root.join('../support/files/rules.yml')
    end
  end
  after(:all) { HealthyData.item_rules = nil }

  let!(:item_outside_sql){ create(:item, amount: 5, start_date: 10.days.ago) }
  let!(:item_1){ create(:item, amount: 30, start_date: 1.days.ago) }
  let!(:item_2){ create(:item, amount: 20, start_date: 10.days.ago) }
  let!(:item_3){ create(:item, amount: 100, start_date: 10.days.from_now) }

  let(:rule_config) { HealthyData.item_rules_for('Item') }

  subject { described_class.new(rule_config) }

  describe '#items' do
    it 'returns items as Struct objects' do
      items = subject.send(:items)

      expect(items.size).to eq 3
      expect(items.find{|item| item.amount == 5}).to be_nil
    end
  end

  describe '#call' do
    it 'creates the ItemCheck objects' do
      expect(HealthyData::ItemCheck.count).to eq 0

      subject.call

      # the only item with bad data is item_3 because of the date
      expect(HealthyData::ItemCheck.count).to eq 1
      item_check = HealthyData::ItemCheck.first
      expect(item_check.checkable).to eq item_3
    end
  end
end

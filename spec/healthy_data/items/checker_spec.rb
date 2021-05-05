require 'rails_helper'
require 'fileutils'

RSpec.describe HealthyData::Items::Checker do
  before(:each) do
    HealthyData.setup do |config|
      config.item_rules_file_location = rules_file_location
    end
  end

  after(:all) { HealthyData.item_rules = nil }

  subject { described_class.new(item, 'Item') }

  describe '#call' do
    context 'valid rules' do
      let(:rules_file_location) { Rails.root.join('../support/files/rules.yml') }
      let(:item) { create(:item, amount: 32.0, start_date: 3.days.from_now ) }

      it 'creates the proper item check' do
        expect(HealthyData::ItemCheck.all).to be_blank

        subject.call

        # The amount is correct but not the date.
        expect(HealthyData::ItemCheck.count).to eq 1

        item_check = HealthyData::ItemCheck.first
        expect(item_check).not_to be_blank
        expect(item_check.checkable).to eq item
        expect(item_check.solved).to be false
        expect(item_check.rule).to eq 'date_attribute_is_past'
      end
    end

    context 'missing args' do
      let(:rules_file_location) { Rails.root.join('../support/files/rules_without_args.yml') }
      let(:item) { create(:item, amount: nil, start_date: nil ) }

      it 'raises the missing args error' do
        expect(HealthyData::ItemCheck.all).to be_blank
        expect { subject.call }.to raise_error(HealthyData::MissingArgsError)
        expect(HealthyData::ItemCheck.all).to be_blank
      end
    end

    context 'bad rule name' do
      let(:rules_file_location) { Rails.root.join('../support/files/rules_with_wrong_name.yml') }
      let(:item) { create(:item, amount: nil, start_date: nil ) }

      it 'raises the missing args error' do
        expect(HealthyData::ItemCheck.all).to be_blank
        expect { subject.call }.to raise_error(HealthyData::InvalidRuleNameError)
        expect(HealthyData::ItemCheck.all).to be_blank
      end
    end
  end
end

require 'rails_helper'

RSpec.describe HealthyData::Items::Rules::AttributesArePresent do

  let(:item) { create(:item, start_date: start_date, end_date: end_date) }
  let(:model_name) { 'Item' }
  let(:args) { {attributes: ['start_date', 'end_date']} }

  subject { described_class.new(item: item, model_name: model_name, args: args) }

  context 'check passes' do
    let(:start_date) { 3.months.ago }
    let(:end_date) { 1.week.ago }

    describe '#call' do
      it 'does not create item check for the item' do
        subject.call

        expect(HealthyData::ItemCheck.all).to be_blank
      end
    end
  end

  context 'check does not pass' do
    let(:start_date) { nil }
    let(:end_date) { nil }

    describe '#call' do
      it 'create item check for the item. mark it as solved once fixed' do
        subject.call

        item_check = HealthyData::ItemCheck.first
        expect(item_check).not_to be_blank
        expect(item_check.checkable).to eq item
        expect(item_check.solved).to be false
        expect(item_check.result).to eq "start_date is missing. end_date is missing"

        item.update(start_date: 1.year.ago, end_date: 1.month.ago)

        item_check.reload.recheck

        expect(item_check.reload.solved).to be true
      end
    end
  end

end

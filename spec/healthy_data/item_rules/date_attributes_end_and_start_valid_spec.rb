require 'rails_helper'

RSpec.describe HealthyData::ItemRules::DateAttributesEndAndStartValid do

  let(:item) { create(:item, start_date: start_date, end_date: end_date) }
  let(:model_name) { 'Item' }
  let(:args) { {start_date_attribute: 'start_date', end_date_attribute: 'end_date'} }

  subject { described_class.new(item: item, model_name: model_name, args: args) }

  context 'check passes' do
    let(:start_date) { 1.year.ago }
    let(:end_date) { 2.months.ago }

    describe '#call' do
      it 'does not create item check for the item' do
        subject.call

        expect(HealthyData::ItemCheck.all).to be_blank
      end
    end
  end

  context 'check does not pass' do
    let(:start_date) { 1.year.ago }
    let(:end_date) { 13.months.ago }

    describe '#call' do
      it 'create item check for the item. mark it as solved once fixed' do
        subject.call

        item_check = HealthyData::ItemCheck.first
        expect(item_check).not_to be_blank
        expect(item_check.checkable).to eq item
        expect(item_check.solved).to be false

        item.update(end_date: 10.months.ago)

        item_check.reload.recheck

        expect(item_check.reload.solved).to be true
      end
    end
  end

end

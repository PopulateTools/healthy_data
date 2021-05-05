require 'rails_helper'

RSpec.describe HealthyData::Items::Rules::DateAttributeIsPast do

  let(:item) { create(:item, end_date: end_date) }
  let(:model_name) { 'Item' }
  let(:args) { {attribute: 'end_date'} }

  subject { described_class.new(item: item, model_name: model_name, args: args) }

  context 'check passes' do
    let(:end_date) { 5.days.ago }

    describe '#call' do
      it 'does not create item check for the item' do
        subject.call

        expect(HealthyData::ItemCheck.all).to be_blank
      end
    end
  end

  context 'check does not pass' do
    let(:end_date) { 5.days.from_now }

    describe '#call' do
      it 'create item check for the item. mark it as solved once fixed' do
        subject.call

        item_check = HealthyData::ItemCheck.first
        expect(item_check).not_to be_blank
        expect(item_check.checkable).to eq item
        expect(item_check.solved).to be false

        item.update(end_date: 3.days.ago)

        item_check.reload.recheck

        expect(item_check.reload.solved).to be true
      end
    end
  end

end

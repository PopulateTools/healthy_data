require 'rails_helper'
require 'fileutils'

RSpec.describe HealthyData::Setup do
  describe 'setup' do
    before(:all) do
      FileUtils.cp Rails.root.join('../support/files/rules.yml'),
        Rails.root.join('config/healthy_data.yml')
    end

    after(:all){ FileUtils.rm(Rails.root.join('config/healthy_data.yml')) }

    after(:each) { HealthyData.item_rules = nil }

    context 'valid setup' do
      let(:expected_rules) do
        YAML.load_file(Rails.root.join('../support/files/rules.yml'))
      end

      it 'returns a valid list of rules' do
        HealthyData.setup do |config|
          config.item_rules_file_location = Rails.root.join("config/healthy_data.yml")
        end

        expect(HealthyData.item_rules).to eq expected_rules
      end
    end

    context 'missing setup' do
      it 'returns nil' do
        HealthyData.setup do |config|
          config.item_rules_file_location = Rails.root.join("config/healthy_data_bad_path.yml")
        end

        expect(HealthyData.item_rules).to be_nil
      end
    end
  end
end

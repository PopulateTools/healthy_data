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

    subject do
      HealthyData.setup do |config|
        config.item_rules_file_location = rules_file_location
      end
    end

    context 'valid setup' do
      let(:rules_file_location) { Rails.root.join("config/healthy_data.yml") }

      let(:expected_rules) do
        YAML.load_file(Rails.root.join('../support/files/rules.yml'))
      end

      it 'returns a valid list of rules' do
        subject
        expect(HealthyData.item_rules).to eq expected_rules
      end
    end

    context 'bad rule name' do
      let(:rules_file_location) { Rails.root.join('../support/files/rules_with_wrong_name.yml') }

      it 'raises the missing args error' do
        expect { subject }.to raise_error(HealthyData::InvalidRuleNameError)
      end
    end

    context 'missing setup' do
      let(:rules_file_location) { Rails.root.join("config/nonexistent_file.yml") }

      it 'returns nil' do
        expect { subject }.to raise_error(HealthyData::MissingConfigFileError)
      end
    end

  end
end

require 'rails_helper'

RSpec.describe HealthyData do
  it "has a version" do
    expect(HealthyData::VERSION).not_to be_nil
  end
end

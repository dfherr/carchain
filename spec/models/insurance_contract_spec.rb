require 'rails_helper'

RSpec.describe InsuranceContract, type: :model do
  it "has a valid factory" do
    expect(build(:insurance_contract).save).to be_truthy
  end
end

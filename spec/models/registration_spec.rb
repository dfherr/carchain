require 'rails_helper'

RSpec.describe CarRegistration, type: :model do
  it "has a valid factory" do
    expect(build(:car_registration).save).to be_truthy
  end
end

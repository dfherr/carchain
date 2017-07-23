require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user).save).to be_truthy
  end

  it "has a valid confirmed_user factory" do
    expect(build(:confirmed_user).save).to be_truthy
  end

  it "requires presence of firstname" do
    expect {
      build(:user, firstname: nil).save
    }.to raise_error(ActiveRecord::NotNullViolation)
  end

  it "requires presence of lastname" do
    expect {
      build(:user, lastname: nil).save
    }.to raise_error(ActiveRecord::NotNullViolation)
  end
end

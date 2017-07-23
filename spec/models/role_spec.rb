require 'rails_helper'

RSpec.describe Role, type: :model do
  let(:user) { create(:user) }

  it "it can add roles to users" do
    user.add_role :admin
    expect(user.has_role?(:admin)).to be_truthy
  end

  it "it can add multiple roles to users" do
    user.add_role :admin
    user.add_role :lawenforcement
    expect(user.has_role?(:admin)).to be_truthy
    expect(user.has_role?(:lawenforcement)).to be_truthy
  end

  it "has role shortcuts" do
    user.add_role :admin
    expect(user.is_admin?).to be_truthy
  end
end

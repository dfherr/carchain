require 'rails_helper'

RSpec.describe "the signin process", type: :feature do
  before(:each) do
    create(:confirmed_user, email: "user@email.com", password: "password", password_confirmation: "password")
  end

  it "signs me in" do
    visit '/users/sign_in'
    within("#new_user") do
      fill_in 'Email', with: 'user@email.com'
      fill_in 'Password', with: 'password'
    end
    click_button 'Log in'
    expect(page).to have_content 'Signed in successfully.'
  end
end

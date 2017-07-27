require 'rails_helper'

RSpec.describe Car::RegistrationController, type: :controller do
  let(:user) {
    create(:confirmed_user)
  }
  before :each do
    sign_in user
  end

  describe "GET index" do
    it "renders the car overview" do
      get :index
      expect(response).to render_template("index")
    end
  end

  # describe "POST create_registration" do
  #   before :each do
  #      @file = fixture_file_upload(Rails.root.join('spec/fixtures/files/pdf-sample.pdf'), 'application/pdf')
  #   end
  #   it "renders the car overview" do
  #     post :create_registration
  #     expect(response).to redirect_to car_registration_path
  #   end
  #   after :each do
  #     @file.close
  #   end
  # end
end

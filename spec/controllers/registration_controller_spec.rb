require 'rails_helper'

RSpec.describe Car::RegistrationController, type: :controller do
  let(:user) {
    create(:confirmed_user)
  }

  describe "GET index" do
    it "renders the car overview" do
      sign_in user
      get :index
      expect(response).to render_template("index")
    end
  end
end

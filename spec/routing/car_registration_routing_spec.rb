require "rails_helper"

RSpec.describe Car::RegistrationController, type: :routing do
  describe "routing" do
    it "get /car/registration/register routes to car/registration#register" do
      expect(get: "/car/registration/register").to route_to("car/registration#register")
    end

    it "get /car/registration/end_registration routes to car/registration#end_registration" do
      expect(get: "/car/registration/end_registration").to route_to("car/registration#end_registration")
    end

    it "get /registration/change_registration routes to car/registration#change_registration" do
      expect(get: "/car/registration/change_registration").to route_to("car/registration#change_registration")
    end
  end
end

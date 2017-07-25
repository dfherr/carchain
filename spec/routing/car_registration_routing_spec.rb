require "rails_helper"

RSpec.describe Car::RegistrationController, type: :routing do
  describe "routing" do
    it "get /car/registration/register routes to car/registration#register" do
      expect(get: "/car/registration/register").to route_to("car/registration#register")
    end

    it "get /car/registration/end_registration routes to car/registration#end_registration" do
      expect(get: "/car/registration/end_registration").to route_to("car/registration#end_registration")
    end

    it "get /registration/details routes to car/registration#details" do
      expect(get: "/car/registration/details/1").to route_to(controller: "car/registration", action: "details", id: "1")
    end
  end
end

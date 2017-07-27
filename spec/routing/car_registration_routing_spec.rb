require "rails_helper"

RSpec.describe Car::RegistrationController, type: :routing do
  describe "routing" do
    it "get /car/registration/register routes to car/registration#register" do
      expect(get: "/car/registration/register").to route_to("car/registration#register")
    end

    it "post /car/registration/register routes to car/registration#create_registration" do
      expect(post: "/car/registration/register").to route_to("car/registration#create_registration")
    end

    it "post /car/registration/cancel routes to car/registration#cancel_registration" do
      expect(post: "/car/registration/cancel/1").to route_to(controller: "car/registration",
                                                             action: "cancel_registration",
                                                             id: "1")
    end

    it "get /registration/details routes to car/registration#details" do
      expect(get: "/car/registration/details/1").to route_to(controller: "car/registration",
                                                             action: "details",
                                                             id: "1")
    end
  end
end

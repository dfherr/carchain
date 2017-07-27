require "rails_helper"

RSpec.describe Car::OfficialController, type: :routing do
  describe "routing" do
    it "get /car/official routes to car/official#index" do
      expect(get: "/car/official").to route_to("car/official#index")
    end

    it "get /car/official/details routes to car/official#details" do
      expect(get: "/car/official/details/1").to route_to(controller: "car/official",
                                                         action: "details",
                                                         id: "1")
    end

    it "post /car/official/accept routes to car/official#accept_registration" do
      expect(post: "/car/official/accept/1").to route_to(controller: "car/official",
                                                         action: "accept_registration",
                                                         id: "1")
    end

    it "post /car/official/incomplete routes to car/official#incomplete_registration" do
      expect(post: "/car/official/incomplete/1").to route_to(controller: "car/official",
                                                             action: "incomplete_registration",
                                                             id: "1")
    end

    it "post /car/official/decline routes to car/official#decline_registration" do
      expect(post: "/car/official/decline/1").to route_to(controller: "car/official",
                                                          action: "decline_registration",
                                                          id: "1")
    end
  end
end

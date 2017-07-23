require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/").to route_to("home#index")
    end

    it "get /imprit routes to home#imprint" do
      expect(get: "/imprint").to route_to("home#imprint")
    end
  end
end

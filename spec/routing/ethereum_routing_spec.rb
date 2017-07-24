require "rails_helper"

RSpec.describe EthereumController, type: :routing do
  describe "routing" do
    it "get /ethereum/web3_client_version routes to ethereum#web3_client_version" do
      expect(get: "/ethereum/web3_client_version").to route_to("ethereum#web3_client_version")
    end
  end
end

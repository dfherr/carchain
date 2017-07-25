require "rails_helper"

RSpec.describe ParityController, type: :routing do
  describe "routing" do
    it "get /parity/web3_client_version routes to parity#web3_client_version" do
      expect(get: "/parity/web3_client_version").to route_to("parity#web3_client_version")
    end

    it "get /parity/generate_signer_token routes to parity#generate_signer_token" do
      expect(get: "/parity/generate_signer_token").to route_to("parity#generate_signer_token")
    end
  end
end

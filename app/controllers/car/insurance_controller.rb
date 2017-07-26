module Car
  class InsuranceController < ApplicationController
    before_action :authorize

    def search_for_registration
      @registrations = current_user.car_registrations
      client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
      client.gas_price = 0
      contract = Ethereum::Contract.create(name: "RegisterCar",
                                           address: "0xAec4f25D8EB795B14F665ceb88B6FD9114C34bCE",
                                           abi: "",
                                           client: client)
      contract.key = Rails.configuration.eth_deploy_key
      puts contract.call.lookup_register_contract([Digest::SHA3.hexdigest("test", 256)].pack('H*'))
    end

    private

    def authorize
      authorize! :manage, InsuranceController
    end
  end
end

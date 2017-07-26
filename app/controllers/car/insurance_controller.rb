module Car
  class InsuranceController < ApplicationController
    before_action :authorize

    # searches for a existing registration in the blockchain by a evb number
    def search_for_registration
      params.require(:evb_number)
      ic = InsuranceContract.first
      @result = {}
      return unless ic
      client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
      client.gas_price = 0
      contract = Ethereum::Contract.create(name: "InsuranceLookup",
                                           address: ic.contract_address,
                                           abi: ic.contract_abi,
                                           client: client)
      evb_number_hash = Digest::SHA3.hexdigest(params[:evb_number], 256)
      reg_address = contract.call.lookup_register_contract([evb_number_hash].pack('H*'))
      reg = CarRegistration.find_by(contract_address: "0x" + reg_address)
      return unless reg
      reg_contract = Ethereum::Contract.create(name: "RegisterCar",
                                               address: reg.contract_address,
                                               abi: reg.contract_abi,
                                               client: client)
      @result[:owner] = "#{reg_contract.call.owner_firstname} #{reg_contract.call.owner_lastname}"
      @result[:license_tag] = reg_contract.call.license_tag
      @result[:status] = CarRegistration::REGISTER_STATE[reg_contract.call.state]
      @result[:updated] = Time.at(reg_contract.call.update_time.to_i).getlocal('+02:00').strftime("%d.%m.%Y %H:%M")
    end

    private

    def authorize
      authorize! :manage, InsuranceController
    end
  end
end

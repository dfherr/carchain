module Car
  # The InsuranceController handles all requests of insurance-role users. At the moment this
  # includes the statically rendered index page and the search for a registration
  #
  class InsuranceController < ApplicationController
    before_action :authorize

    # searches for a existing registration in the blockchain
    # by a evb_number's SHA3 keccak hash
    #
    def search_for_registration
      params.require(:evb_number)
      # get the insurance lookup contract
      ic = InsuranceContract.first
      @result = {}
      return unless ic
      # initialize the ethereum_client and the InsuranceLookup contract
      client = ethereum_client
      contract = Ethereum::Contract.create(name: "InsuranceLookup",
                                           address: ic.contract_address,
                                           abi: ic.contract_abi,
                                           client: client)
      # create the evb_number hash
      evb_number_hash = Digest::SHA3.hexdigest(params[:evb_number], 256)
      # lookup matching registration in ethereum
      reg_address = contract.call.lookup_register_contract([evb_number_hash].pack('H*'))
      reg = CarRegistration.find_by(contract_address: "0x" + reg_address)
      return unless reg
      # create the registration contract, if a matching registration address was found
      reg_contract = Ethereum::Contract.create(name: "RegisterCar",
                                               address: reg.contract_address,
                                               abi: reg.contract_abi,
                                               client: client)
      # retrieve data from the registration contract
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

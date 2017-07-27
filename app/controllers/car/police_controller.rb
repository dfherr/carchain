module Car
  class PoliceController < ApplicationController
    before_action :authorize

    def search_for_owner
      params.require(:license_tag)
      pc = PoliceContract.first
      @result = {}
      return unless pc
      client = ethereum_client
      contract = Ethereum::Contract.create(name: "PoliceLookup",
                                           address: pc.contract_address,
                                           abi: pc.contract_abi,
                                           client: client)
      license_tag_hash = Digest::SHA3.hexdigest(params[:license_tag].capitalize, 256)
      puts license_tag_hash
      reg_address = contract.call.lookup_register_contract([license_tag_hash].pack('H*'))
      reg = CarRegistration.find_by(contract_address: "0x" + reg_address)
      return unless reg
      reg_contract = Ethereum::Contract.create(name: "RegisterCar",
                                               address: reg.contract_address,
                                               abi: reg.contract_abi,
                                               client: client)
      # halterdaten
      @result[:owner_firstname] = reg_contract.call.owner_firstname
      @result[:owner_lastname] = reg_contract.call.owner_lastname
      @result[:street] = "#{reg_contract.call.owner_street} #{reg_contract.call.owner_street_number}"
      @result[:city] = "#{reg_contract.call.owner_zipcode} #{reg_contract.call.owner_city}"
      @result[:birthdate] = reg_contract.call.owner_birthdate

      # kfz daten
      @result[:status_id] = reg_contract.call.state
      @result[:status] = CarRegistration::REGISTER_STATE[reg_contract.call.state]
      @result[:updated] = Time.at(reg_contract.call.update_time.to_i).getlocal('+02:00').strftime("%d.%m.%Y %H:%M")
      @result[:license_tag] = reg_contract.call.license_tag
    end

    private

    def authorize
      authorize! :manage, PoliceController
    end
  end
end

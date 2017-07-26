module Car
  class OfficialController < ApplicationController
    def index
      registrations = CarRegistration.all
      client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
      client.gas_price = 0

      @table_data = []

      registrations.each do |reg|
        row = {}
        row[:id] = reg.id
        contract = Ethereum::Contract.create(name: "RegisterCar",
                                             address: reg.contract_address,
                                             abi: reg.contract_abi,
                                             client: client)
        row[:reference] = reg.contract_address.sub(/^0x/, '')
        row[:status] = CarRegistration::REGISTER_STATE[contract.call.state]
        row[:owner] = "#{contract.call.owner_firstname} #{contract.call.owner_lastname}"
        row[:time] = Time.at(contract.call.timestamp.to_i).strftime("%d.%m.%Y")
        @table_data << row
      end
    end

    def accept_registration
      params.require(:id)
      client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
      client.gas_price = 0

      registration = CarRegistration.find(params[:id])

      unless registration
        flash[:notice] = "Antrag existiert nicht."
        return redirect_to car_official_path
      end

      contract = Ethereum::Contract.create(name: "RegisterCar",
                                           address: registration.contract_address,
                                           abi: registration.contract_abi,
                                           client: client)
      contract.key = Rails.configuration.eth_deploy_key
      contract.transact_and_wait.accept("M - FX17")
      render json: { license: contract.call.license_tag, state: contract.call.state }
    end
  end
end

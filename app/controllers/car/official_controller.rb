module Car
  class OfficialController < ApplicationController
    def index
      registrations = CarRegistration.all
      @table_data = []

      registrations.each do |reg|
        row = {}
        row[:id] = reg.id
        contract = registration_contract(reg)
        row[:reference] = reg.contract_address.sub(/^0x/, '')
        row[:status] = CarRegistration::REGISTER_STATE[contract.call.state]
        row[:owner] = "#{contract.call.owner_firstname} #{contract.call.owner_lastname}"
        row[:time] = Time.at(contract.call.update_time.to_i).getlocal('+02:00').strftime("%d.%m.%Y %H:%M")
        @table_data << row
      end
    end

    def details
      begin
        registration = CarRegistration.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "Antrag existiert nicht."
        return redirect_to car_official_path
      end

      reg_contract = registration_contract(registration)
      @result = {}
      # allgemeine daten
      @result[:id] = registration.id
      @result[:ref] = reg_contract.address.sub(/^0x/, '')

      # halterdaten
      @result[:owner_firstname] = reg_contract.call.owner_firstname
      @result[:owner_lastname] = reg_contract.call.owner_lastname
      @result[:street] = "#{reg_contract.call.owner_street} #{reg_contract.call.owner_street_number}"
      @result[:city] = "#{reg_contract.call.owner_zipcode} #{reg_contract.call.owner_city}"
      @result[:birthdate] = reg_contract.call.owner_birthdate

      # kfz daten
      @result[:status_id] = reg_contract.call.state
      @result[:status] = CarRegistration::REGISTER_STATE[@result[:status_id]]
      @result[:updated] = Time.at(reg_contract.call.update_time.to_i).getlocal('+02:00').strftime("%d.%m.%Y %H:%M")
      @result[:license_tag] = reg_contract.call.license_tag
      @result[:evb] = reg_contract.call.evb_number
      @result[:vehicle_number] = reg_contract.call.vehicle_number

      # dokumente
      @result[:identity_card] = registration.identity_card_file_name
      @result[:coc] = registration.coc_file_name
      @result[:cert_reg] = registration.certificate_registration_file_name || "Nicht eingereicht"
      @result[:cert_title] = registration.certificate_title_file_name
      @result[:hu] = registration.hu_file_name
    end

    def accept_registration
      params.require(:id)
      params.require(:license_tag)

      pc_address = police_conctract_address

      begin
        registration = CarRegistration.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "Antrag existiert nicht."
        return redirect_to car_official_path
      end

      contract = registration_contract(registration)

      contract.key = Rails.configuration.eth_deploy_key
      contract.transact_and_wait.accept(params[:license_tag].capitalize, pc_address)
      redirect_to car_official_path
    end

    def incomplete_registration
      params.require(:id)
      begin
        registration = CarRegistration.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "Antrag existiert nicht."
        return redirect_to car_official_path
      end

      contract = registration_contract(registration)

      contract.key = Rails.configuration.eth_deploy_key
      contract.transact_and_wait.incomplete
      redirect_to car_official_path
    end

    def decline_registration
      params.require(:id)
      begin
        registration = CarRegistration.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "Antrag existiert nicht."
        return redirect_to car_official_path
      end

      contract = registration_contract(registration)

      contract.key = Rails.configuration.eth_deploy_key
      contract.transact_and_wait.decline
      redirect_to car_official_path
    end

    private

    # create the registration contract from registration model
    def registration_contract(registration)
      Ethereum::Contract.create(name: "RegisterCar",
                                address: registration.contract_address,
                                abi: registration.contract_abi,
                                client: ethereum_client)
    end

    # returns the police contract address, or creates and deploys it if there is none yet
    def police_conctract_address
      return PoliceContract.first.contract_address if PoliceContract.count > 0

      client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
      client.gas_price = 0
      contract = Ethereum::Contract.create(file: "smartcontracts/PoliceMapping.sol", client: client)
      contract.key = Rails.configuration.eth_deploy_key
      contract.deploy_and_wait
      pc = PoliceContract.create(contract_address: contract.address, contract_abi: contract.abi)
      pc.contract_address
    end
  end
end

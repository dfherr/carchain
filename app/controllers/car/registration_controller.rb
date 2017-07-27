module Car
  class RegistrationController < ApplicationController
    before_action :authorize

    def index
      registrations = current_user.car_registrations

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

    def register; end

    # shows the details of a registration
    def details
      begin
        registration = CarRegistration.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "Antrag existiert nicht."
        return redirect_to car_official_path
      end
      if registration.user_id == current_user.id
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
        @result[:status] = CarRegistration::REGISTER_STATE[reg_contract.call.state]
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
      else
        flash[:alert] = "Not authorized."
        return redirect_to car_registration_path
      end
    end

    # This is the core method of adding a registration to the ethereum backend
    #
    #
    def create_registration
      # make params necessary
      params.require(:firstname)
      params.require(:lastname)
      params.require(:birthdate)
      params.require(:street)
      params.require(:street_number)
      params.require(:zipcode)
      params.require(:city)
      params.require(:vehicle_number)
      params.require(:identity_card)
      params.require(:coc)
      params.require(:evb)
      params.require(:certificate_title)
      params.require(:hu)

      # get the insurance lookup contract
      ic_address = insurance_conctract_address

      # hash files
      identity_card_file_data = params[:identity_card].tempfile.read
      identity_card_file_name = params[:identity_card].original_filename
      identity_card_hash = Digest::SHA3.hexdigest(identity_card_file_data, 256)
      coc_file_data = params[:coc].tempfile.read
      coc_file_name = params[:coc].original_filename
      coc_hash = Digest::SHA3.hexdigest(coc_file_data, 256)
      if params[:certificate_registration].respond_to? :tempfile
        certificate_registration_file_data = params[:certificate_registration].tempfile.read
        certificate_registration_file_name = params[:certificate_registration].original_filename
        certificate_registration_hash = Digest::SHA3.hexdigest(certificate_registration_file_data, 256)
      else
        certificate_registration_file_data = nil
        certificate_registration_file_name = nil
        certificate_registration_hash = nil
      end
      certificate_title_file_data = params[:certificate_title].tempfile.read
      certificate_title_file_name = params[:certificate_title].original_filename
      certificate_title_hash = Digest::SHA3.hexdigest(certificate_title_file_data, 256)
      hu_file_data = params[:hu].tempfile.read
      hu_file_name = params[:hu].original_filename
      hu_hash = Digest::SHA3.hexdigest(hu_file_data, 256)

      # init client
      client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
      client.gas_price = 0
      # create contract from source files
      contract = Ethereum::Contract.create(file: "smartcontracts/RegisterCar.sol", client: client, contract_index: 1)
      contract.key = Rails.configuration.eth_deploy_key
      # deploy contract with values
      contract.deploy_and_wait(
        params[:firstname],
        params[:lastname],
        params[:birthdate],
        params[:street],
        params[:street_number],
        params[:zipcode],
        params[:city],
        params[:vehicle_number],
        params[:evb],
        [identity_card_hash].pack('H*'),
        [coc_hash].pack('H*'),
        [certificate_registration_hash].pack('H*'),
        [certificate_title_hash].pack('H*'),
        [hu_hash].pack('H*'),
        ic_address
      )
      # add contract and actual files to database for reference
      current_user.car_registrations.create(contract_address: contract.address) do |cr|
        cr.contract_abi = contract.abi.to_json
        cr.identity_card_sha3_256 = identity_card_hash
        cr.identity_card_file_name = identity_card_file_name
        cr.identity_card_file = identity_card_file_data

        cr.coc_sha3_256 = coc_hash
        cr.coc_file_name = coc_file_name
        cr.coc_file = coc_file_data

        cr.certificate_registration_sha3_256 = certificate_registration_hash
        cr.certificate_registration_file_name = certificate_registration_file_name
        cr.certificate_registration_file = certificate_registration_file_data

        cr.certificate_title_sha3_256 = certificate_title_hash
        cr.certificate_title_file_name = certificate_title_file_name
        cr.certificate_title_file = certificate_title_file_data

        cr.hu_sha3_256 = hu_hash
        cr.hu_file_name = hu_file_name
        cr.hu_file = hu_file_data
      end
      # redirect back to overview
      redirect_to car_registration_path
    end

    # set the registration state to cancled and remove licensetag
    def cancel_registration
      begin
        registration = CarRegistration.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = "Antrag existiert nicht."
        return redirect_to car_official_path
      end
      if registration.user_id == current_user.id
        reg_contract = registration_contract(registration)
        reg_contract.key = Rails.configuration.eth_deploy_key
        reg_contract.transact_and_wait.cancel
      else
        flash[:alert] = "Not authorized."
      end
      redirect_to car_registration_path
    end

    private

    def authorize
      authorize! :manage, CarRegistration
    end

    # returns the insurance contract address, or creates and deploys it if there is none yet
    def insurance_conctract_address
      return InsuranceContract.first.contract_address if InsuranceContract.count > 0

      client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
      client.gas_price = 0
      contract = Ethereum::Contract.create(file: "smartcontracts/InsuranceMapping.sol", client: client)
      contract.key = Rails.configuration.eth_deploy_key
      contract.deploy_and_wait
      ic = InsuranceContract.create(contract_address: contract.address, contract_abi: contract.abi)
      ic.contract_address
    end

    # create the registration contract from registration model
    def registration_contract(registration)
      Ethereum::Contract.create(name: "RegisterCar",
                                address: registration.contract_address,
                                abi: registration.contract_abi,
                                client: ethereum_client)
    end
  end
end

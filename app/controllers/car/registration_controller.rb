module Car
  class RegistrationController < ApplicationController
    before_action :authorize

    def index
      registrations = current_user.car_registrations
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

    def register; end

    def details; end

    def create_registration
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

      # hash files
      identity_card_file_data = params[:identity_card].tempfile.read
      identity_card_hash = Digest::SHA3.hexdigest(identity_card_file_data, 256)
      coc_file_data = params[:coc].tempfile.read
      coc_hash = Digest::SHA3.hexdigest(coc_file_data, 256)
      if params[:certificate_registration].respond_to? :tempfile
        certificate_registration_file_data = params[:certificate_registration].tempfile.read
        certificate_registration_hash = Digest::SHA3.hexdigest(certificate_registration_file_data, 256)
      else
        certificate_registration_file_data = nil
        certificate_registration_file_data = nil
      end
      certificate_title_file_data = params[:certificate_title].tempfile.read
      certificate_title_hash = Digest::SHA3.hexdigest(certificate_registration_file_data, 256)
      hu_file_data = params[:hu].tempfile.read
      hu_hash = Digest::SHA3.hexdigest(hu_file_data, 256)

      client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
      client.gas_price = 0
      contract = Ethereum::Contract.create(file: "smartcontracts/RegisterCar.sol", client: client)
      contract.key = Rails.configuration.eth_deploy_key
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
        [hu_hash].pack('H*')
      )
      current_user.car_registrations.create(contract_address: contract.address) do |cr|
        cr.contract_abi = contract.abi.to_json
        cr.identity_card_file = identity_card_file_data
        cr.identity_card_sha3_256 = identity_card_hash
        cr.coc_file = coc_file_data
        cr.coc_sha3_256 = coc_hash
        cr.certificate_registration_file = certificate_registration_file_data
        cr.certificate_registration_sha3_256 = certificate_registration_hash
        cr.certificate_title_file = certificate_title_file_data
        cr.certificate_title_sha3_256 = certificate_title_hash
        cr.hu_file = hu_file_data
        cr.hu_sha3_256 = hu_hash
      end
      redirect_to car_registration_path
    end

    def end_registration; end

    def change_registration; end

    private

    def authorize
      authorize! :manage, CarRegistration
    end
  end
end

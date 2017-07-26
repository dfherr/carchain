class ParityController < ApplicationController
  def web3_client_version
    data = {
      method: "web3_clientVersion",
      id: 1,
      jsonrpc: "2.0",
      params: []
    }
    resp = send_json_rpc_request(data)
    render json: resp.body
  end

  def generate_signer_token
    data = {
      method: "signer_generateAuthorizationToken",
      id: 1,
      jsonrpc: "2.0",
      params: []
    }
    resp = send_json_rpc_request(data)
    render json: resp.body
  end

  def deploy_contract
    # client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
    # client.gas_price = 0
    # contract = Ethereum::Contract.create(file: "smartcontracts/RegisterCar.sol", client: client)
    # contract.key = Rails.configuration.eth_deploy_key
    # address = contract.deploy_and_wait(
    #   "Dennis-Florian",
    #   "Herr",
    #   "12.11.1990",
    #   "Gustav",
    #   "35",
    #   "81739",
    #   "München",
    #   "123",
    #   "123",
    #   ["b1b1bd1ed240b1496c81ccf19ceccf2af6fd24fac10ae42023628abbe2687310"].pack('H*'),
    #   ["1bf0b26eb2090599dd68cbb42c86a674cb07ab7adc103ad3ccdf521bb79056b9"].pack('H*'),
    #   ["b410677b84ed73fac43fcf1abd933151dd417d932a0ef9b0260ecf8b7b72ecb9"].pack('H*'),
    #   ["86bc56fc56af4c3cde021282f6b727ee9f90dd636e0b0c712a85d416c75e652d"].pack('H*'),
    #   ["0c67354981e9068905680b57898ad4f04b993c63eb66aa3f19cdfdc71d88077e"].pack('H*')
    # )
    #
    # a = contract.transact_and_wait
    # puts a
    # puts a.class
    #
    # return render json: { address: address.to_s,
    #                       state: contract.call.state,
    #                       identiy: contract.call.hash_identidy_card.unpack1('H*') }
    render json: ["method disabled"]
  end

  private

  def send_json_rpc_request(data)
    RestClient.post Rails.configuration.parity_json_rpc_url,
                    data.to_json,
                    content_type: :json, accept: :json
  end
end

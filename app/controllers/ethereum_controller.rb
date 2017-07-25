class EthereumController < ApplicationController
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

  def owner_data
    contract = params[:contract]
    data = {
      method: "eth_call",
      id: 1,
      jsonrpc: "2.0",
      params: [
        {
          to: contract,
          data: "0xe4b85399"
        }
      ]
    }
    resp = send_json_rpc_request(data)

    json_resp = JSON.parse(resp.body)
    puts "~~~~~~~~~~~~~~~~~\n\n"
    puts json_resp.inspect
    puts json_resp["result"]
    puts json_resp["result"].sub(/^0x/, '')

    json_resp["result"].sub(/^0x/, '').chars.each_slice(32).map(&:join).each_with_index do |part, i|
      puts "#{i}: " + [part].pack('H*').force_encoding('utf-8').encode('utf-8')
    end
    render json: json_resp.to_json
  end

  def owner_name
    contract = params[:contract]
    data = {
      method: "eth_call",
      id: 1,
      jsonrpc: "2.0",
      params: [
        {
          to: contract,
          data: "0x145ef6e9"
        }
      ]
    }
    resp = send_json_rpc_request(data)

    json_resp = JSON.parse(resp.body)
    puts "~~~~~~~~~~~~~~~~~\n\n"
    puts json_resp.inspect
    puts json_resp["result"]
    puts json_resp["result"].sub(/^0x/, '')

    json_resp["result"].sub(/^0x/, '').chars.each_slice(32).map(&:join).each_with_index do |part, i|
      puts "#{i}: " + [part].pack('H*').force_encoding('utf-8').encode('utf-8')
    end
    render json: json_resp.to_json
  end

  def deploy_contract
    client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
    client.gas_price = 0
    contract = Ethereum::Contract.create(file: "smartcontracts/greeter.sol", client: client)
    contract.key = Rails.configuration.eth_deploy_key
    address = contract.deploy_and_wait("Hello from ethereum.rb!")
    puts contract.address
    puts address
    puts contract.call.get_greeting_type
    abi = contract.abi
    puts abi
    contract.transact_and_wait.set_greeting_hello
    contract_from_address = Ethereum::Contract.create(name: "bla", address: contract.address, abi: abi, client: client)
    render json: { address: address.to_s,
                   greet: contract.call.greet,
                   greeting_type: contract.call.get_greeting_type,
                   greeting_type_from_address: contract_from_address.call.get_greeting_type }
  end

  private

  def send_json_rpc_request(data)
    RestClient.post Rails.configuration.parity_json_rpc_url,
                    data.to_json,
                    content_type: :json, accept: :json
  end
end

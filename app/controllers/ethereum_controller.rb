class EthereumController < ApplicationController
  def web3_client_version
    data = {
      method: "web3_clientVersion",
      id: 1,
      jsonrpc: "2.0",
      params: {}
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
    contract = Ethereum::Contract.create(file: "smartcontracts/CarRegistration.sol")
    address = contract.deploy_and_wait("Hello from ethereum.rb!")
    render json: { address: address }.to_json
  end

  private

  def send_json_rpc_request(data)
    RestClient.post Rails.configuration.parity_json_rpc_url,
                    data.to_json,
                    content_type: :json, accept: :json
  end
end

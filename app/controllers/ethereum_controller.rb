class EthereumController < ApplicationController
  def web3_client_version
    data = {
      method: "web3_clientVersion",
      params: {},
      id: 1,
      jsonrpc: "2.0"
    }
    resp = RestClient.post Rails.configuration.parity_json_rpc_url,
                           data.to_json,
                           content_type: :json, accept: :json
    render json: resp.body
  end
end

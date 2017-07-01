class EthereumController < ApplicationController
  def user
    params.require(:id)
    @user = params[:id].to_i

    # response = RestClient.post 'parity-rest-api-url', {user: params[:id].to_i}.to_json
    # https://github.com/rest-client/rest-client
    render json: { user: @user }
  end

  def register_car
    render json: { car: "YoloCar!" }
  end
end

class EthereumController < ApplicationController
  def register_car
    render json: { car: "YoloCar!" }
  end
end

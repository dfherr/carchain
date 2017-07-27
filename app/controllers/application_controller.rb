class ApplicationController < ActionController::Base
  include FastGettext::Translation
  protect_from_forgery with: :exception
  # insecure, but fails on chrome in production.
  # probably related to docker/nginx setup
  skip_before_action :verify_authenticity_token

  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:change_locale]

  before_action :localize

  def change_locale
    locale = params[:locale]
    cookies[:locale] = locale if FastGettext.available_locales.include? locale
    redirect_back(fallback_location: root_path)
  end

  private

  def localize
    FastGettext.locale = cookies[:locale] || 'de'
  end

  def ethereum_client
    return @client if @client
    @client = Ethereum::HttpClient.new(Rails.configuration.parity_json_rpc_url)
    @client.gas_price = 0
    @client
  end
end

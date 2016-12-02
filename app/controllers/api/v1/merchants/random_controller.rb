class Api::V1::Merchants::RandomController < ApplicationController
  def show
    ids = Merchant.pluck(:id)
    render json: Merchant.find(ids.sample)
  end
end

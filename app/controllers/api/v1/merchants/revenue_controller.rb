class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    render json: Merchant.find(params[:id].revenue
  end

end

class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).revenue(params[:date])

    render json: revenue, serializer: RevenueSerializer
  end
end

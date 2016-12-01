class Api::V1::Merchants::AllMerchantsRevenueController < ApplicationController
  def show
    render json: Merchant.day_revenue(params['date']), serializer: TotalRevenueSerializer
  end
end

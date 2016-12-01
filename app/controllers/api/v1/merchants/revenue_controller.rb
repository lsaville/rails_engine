class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    render json: Merchant.day_revenue(params['date'])    
  end
end

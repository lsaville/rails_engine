class Api::V1::Merchants::RevenueController < ApplicationController
  def show
    revenue = Merchant.find(params[:id]).revenue(params[:date])

    render json: revenue, serializer: RevenueSerializer
=======
    render json: Merchant.day_revenue(params['date']), serializer: RevenueSerializer
>>>>>>> origin/master
  end
end

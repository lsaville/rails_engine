class Api::V1::Customers::FavoriteController < ApplicationController
  def index
    render json: Customer.find(params[:id]).favorite_merchant
  end
end

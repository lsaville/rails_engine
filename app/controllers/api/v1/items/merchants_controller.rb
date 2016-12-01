class Api::V1::Items::MerchantsController < ApplicationController
  def index
    render json: Item.find(params[:id]).merchant
  end
end

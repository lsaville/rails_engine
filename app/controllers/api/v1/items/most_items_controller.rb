class Api::V1::Items::MostItemsController < ApplicationController
  def index
    render json: Item.most_items(params[:quantity].to_i)
  end
end

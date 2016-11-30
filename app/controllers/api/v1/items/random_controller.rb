class Api::V1::Items::RandomController < ApplicationController
  def show
    ids = Item.pluck(:id)
    render json: Item.find(ids.sample)
  end
end

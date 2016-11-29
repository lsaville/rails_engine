class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(find_params)
  end

  private

  def find_params
    params.permit(:name, :id, :created_at, :updated_at)
  end
end

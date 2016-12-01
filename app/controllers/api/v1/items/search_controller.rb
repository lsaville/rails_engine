class Api::V1::Items::SearchController < ApplicationController
  before_action :format_unit_price

  def show
    render json: Item.find_by(items_search_criteria)
  end

  def index
    render json: Item.where(items_search_criteria)
  end

  private

  def items_search_criteria
    params.permit(:name, :id, :description, :unit_price, :merchant_id, :created_at, :updated_at)
  end

  def format_unit_price
    if params[:unit_price]
      params[:unit_price] = (params[:unit_price].to_f * 100).round(0)
    end
  end
end

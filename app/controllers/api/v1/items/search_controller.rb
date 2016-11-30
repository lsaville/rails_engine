class Api::V1::Items::SearchController < ApplicationController
  def show
    render json: Item.find_by(items_search_criteria)
  end

  def index
    render json: Item.where(items_search_criteria)
  end

  private

  def items_search_criteria
    params.permit(:name, :id, :created_at, :updated_at)
  end
end

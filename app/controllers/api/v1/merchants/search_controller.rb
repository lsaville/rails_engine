class Api::V1::Merchants::SearchController < ApplicationController

  def index
    render json: Merchant.where(permit_params)
  end

  def show
    render json: Merchant.find_by(permit_params)
  end

  private

  def permit_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end

end

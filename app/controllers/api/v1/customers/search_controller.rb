class Api::V1::Customers::SearchController < ApplicationController

  def index
    render json: Customer.where(permit_params)
  end

  def show
    render json: Customer.find_by(permit_params)
  end

  private

  def permit_params
    params.permit(:id, :first_name, :last_name, :created_at, :updated_at)
  end

end

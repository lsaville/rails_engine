class Api::V1::Invoices::SearchController < ApplicationController
  def show
    render json: Invoice.find_by(find_params) 
  end

  def index
    render json: Invoice.where(find_params)
  end

  private

  def find_params
    params.permit(:id, :customer_id, :merchant_id, :status, :created_at, :updated_at)
  end
end

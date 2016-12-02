class Api::V1::Merchants::CustomersPendingInvoicesController < ApplicationController
  def index
    render json: Merchant.find(params[:id]).customers_with_pending_invoices
  end
end

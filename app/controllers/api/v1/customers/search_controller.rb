class Api::V1::Customers::SearchController < ApplicationController

  def index
    render json: M.all
  end

  def show
    render json: M.find(params[:id])
  end

end

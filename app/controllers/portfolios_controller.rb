class PortfoliosController < ApplicationController
  before_action :required_signed_in, only: [:show]

  def new
    @portfolio = Portfolio.new
  end

  def index
    @portfolios = Portfolio.where(user: current_user)
  end

  def create
    @portfolio = Portfolio.new(user_params)
    @portfolio.user = current_user
    
    if @portfolio.save
      redirect_to portfolios_path
    else
      render :new
    end
  end

  def show

  end

  private

  def user_params
    params.require(:portfolio).permit(:name)
  end
end

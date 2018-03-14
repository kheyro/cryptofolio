class PortfoliosController < ApplicationController
  before_action :required_signed_in, only: [:show]
  before_action :current_portfolio, only: [:edit, :show, :update, :destroy]

  def new
    @portfolio = Portfolio.new
  end

  def index
    @portfolios = Portfolio.where(user: current_user)
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user = current_user

    if @portfolio.save
      redirect_to portfolios_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @portfolio.update(portfolio_params)
      redirect_to portfolios_path
    else
      render :edit
    end
  end

  def show
    redirect_to root_path, notice: "You are not the owner of this portfolio" if !@portfolio
  end

  def destroy
    @portfolio.destroy
    redirect_to portfolios_path
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name, transactions_attributes: [:coin_id, :trade_date, :trade_price, :trade_quantity])
  end

  def current_portfolio
    @portfolio = Portfolio.find_by(id: params[:id], user: current_user)
  end
end

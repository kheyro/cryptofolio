class TransactionsController < ApplicationController
  before_action :current_user
  before_action :current_transaction, only: [:edit, :update, :destroy]
  before_action :required_signed_in, only: [:edit, :create, :destroy]

  def new
    @transaction = Transaction.new(portfolio_id: params[:portfolio_id])
  end

  def create
    @transaction = Transaction.new(trans_params)
    @transaction.portfolio = Portfolio.find_by_id(params[:portfolio_id])
    if @transaction.save && @transaction.portfolio
      redirect_to portfolio_coin_path(@transaction.portfolio, @transaction.coin), notice: "Transaction successfully added! "
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @transaction.user == current_user && @transaction.update(trans_params)
      redirect_to portfolio_coin_path(@transaction.portfolio, @transaction.coin)
    else
      render :edit
    end
  end

  def destroy
    if @transaction.user == current_user
      @transaction.destroy
    end
    redirect_to portfolio_coin_path(@transaction.portfolio, @transaction.coin)
  end

  private

  def trans_params
    params.require(:transaction).permit(:trade_price, :trade_date, :trade_quantity, :coin_id)
  end

  def current_transaction
    @transaction = Transaction.find_by_id(params[:id])
  end
end

class CoinsController < ApplicationController
  before_action :required_signed_in
  before_action :required_admin, only: [:index]

  def show
    @coin = Coin.find_by(params[:id])
    @transactions = @coin.transactions.where(:user => current_user)
  end

  def index
    @coins = Coin.all
  end

  def update_coin_list
    Coin.update_coins_data
    redirect_to coins_path, notice: "Coin successfully updated!"
  end

end

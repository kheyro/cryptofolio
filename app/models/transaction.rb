class Transaction < ApplicationRecord
  belongs_to :portfolio
  belongs_to :coin
  has_one :user, through: :portfolio

  validates :trade_price, presence: true, numericality: { greater_than: 0}
  validates :trade_date, presence: true
  validates :trade_quantity, presence:true, numericality: { greater_than: 0}

  validate :is_valid_trade_date?

  scope :number_of_transactions, ->(portfolio) { where("portfolio_id = ?", portfolio.id).count }

  def change_24h
    1 - self.trade_price / self.coin.price
  end

  private

  def is_valid_trade_date?
    if !Date.parse(trade_date.strftime("%Y-%m-%d"))|| trade_date.to_date > DateTime.now.to_date
      errors.add(:trade_date, 'Sorry, Invalid trade date entered.')
    end
  end
end

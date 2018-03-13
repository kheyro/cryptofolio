class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :transactions
  has_many :coins, through: :transactions

  validates :name, presence: true

  def number_of_transactions
    Transaction.number_of_transactions(self)
  end

  def total_holding
    self.transactions.map{|t| t.coin.price * t.trade_quantity }.inject(0, &:+)
  end

  def profit_percent
    self.transactions.map{ |t| t.change_24h }.inject(0, &:+) / self.transactions.size if self.transactions.size > 0
  end

  def profit_amount
    profit_percent * total_holding
  end

  def best_performer
    self.transactions.map{ |t| t.change_24h }.sort.last
  end

  def worst_performer
    self.transactions.map{ |t| t.change_24h }.sort.first
  end
end

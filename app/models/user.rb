class User < ApplicationRecord
  has_secure_password

  has_many :transactions
  has_many :coins, through: :transactions

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }

  def self.find_or_create_by_omniauth(auth_hash)
    self.where(email: auth_hash["info"]["email"]).first_or_create do |user|
      user.name = auth_hash["info"]["name"]
      user.password = SecureRandom.hex
    end
  end

  def number_of_transactions
    Transaction.number_of_transactions(self)
  end

  def total_holding
    self.transactions.map{|t| t.coin.price * t.trade_quantity }.inject(0, &:+)
  end

  def user_change_24h
    self.transactions.map{ |t| t.change_24h }.inject(0, &:+) / self.transactions.size if self.transactions.size > 0
  end

  def best_performer
    self.transactions.map{ |t| t.change_24h }.sort.last
  end

  def worst_performer
    self.transactions.map{ |t| t.change_24h }.sort.first
  end

  def admin
    !!self.role_id
  end
end

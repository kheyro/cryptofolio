class Coin < ApplicationRecord
  has_many :transactions
  has_many :uesers, through: :transactions

  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :symbol, presence: true, uniqueness: { case_sensitive: false }

  def coin_stats
    trades = Hash.new(0)
    self.transactions.each do |t|
      if t.trade_quantity > 0
        trades[:total] += t.coin.price * t.trade_quantity
        trades[:number_transaction] += 1
        trades[:cumul_change] += t.trade_price / t.coin.price - 1
        trades[:change] = trades[:cumul_change] / trades[:number_transaction]
      end
    end

    return trades
  end

  def self.update_coins_data
    url = 'https://api.coinmarketcap.com/v1/ticker/'
    response = HTTParty.get(url)
    response = response.parsed_response

    # "id": "bitcoin",
    # "name": "Bitcoin",
    # "symbol": "BTC",
    # "rank": "1",
    # "price_usd": "9178.49",
    # "price_btc": "1.0",
    # "24h_volume_usd": "6941430000.0",
    # "market_cap_usd": "155270679632",
    # "available_supply": "16916800.0",
    # "total_supply": "16916800.0",
    # "max_supply": "21000000.0",
    # "percent_change_1h": "1.16",
    # "percent_change_24h": "-6.19",
    # "percent_change_7d": "-17.02",
    # "last_updated": "1520947465"

    # t.string :name
    # t.string :symbol
    # t.decimal :price
    # t.decimal :high
    # t.decimal :low
    # t.decimal :market_cap
    # t.decimal :percentage_change_24h

    response.each do |coin|
      coin["volume_usd_24h"] = coin["24h_volume_usd"]
      self.where("lower(symbol) = ?", coin["symbol"].downcase).first_or_create! do |c|
        c.name = coin["name"]
        c.symbol = coin["symbol"]
        c.price = coin["price_usd"]
        c.volume = coin["volume_usd_24h"]
        c.market_cap = coin["market_cap_usd"]
        c.percentage_change_24h = coin["percent_change_24h"]
        c.save
      end
    end

  end
end

class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.belongs_to :portfolio, foreign_key: true
      t.belongs_to :coin, foreign_key: true
      t.decimal :trade_quantity
      t.decimal :trade_price
      t.datetime :trade_date

      t.timestamps
    end
  end
end

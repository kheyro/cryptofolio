class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.decimal :price
      t.decimal :market_cap
      t.decimal :percentage_change_24h
      t.decimal :volume

      t.timestamps
    end
  end
end

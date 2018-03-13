class CreateCoins < ActiveRecord::Migration[5.1]
  def change
    create_table :coins do |t|
      t.string :name
      t.string :symbol
      t.decimal :price
      t.decimal :market_cap, :precision => 18
      t.decimal :percentage_change_24h
      t.decimal :volume, :precision => 18

      t.timestamps
    end
  end
end

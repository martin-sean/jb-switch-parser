class CreatePrices < ActiveRecord::Migration[5.2]
  def change
    create_table :prices do |t|
      t.references :game, foreign_key: true
      t.integer :amount
      t.timestamps
    end
  end
end

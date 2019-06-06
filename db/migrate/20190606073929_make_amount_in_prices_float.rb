class MakeAmountInPricesFloat < ActiveRecord::Migration[5.2]
  def change
    change_column :prices, :amount, :float
  end
end

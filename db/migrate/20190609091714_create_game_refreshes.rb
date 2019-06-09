class CreateGameRefreshes < ActiveRecord::Migration[5.2]
  def change
    create_table :game_refreshes do |t|
      t.references :game, foreign_key: true
      t.references :refresh, foreign_key: true

      t.timestamps
    end

    add_index :game_refreshes, [:refresh_id, :game_id], unique: true
  end
end
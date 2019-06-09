class RenameGameRefreshesToGamesRefreshes < ActiveRecord::Migration[5.2]
  def change
    rename_table :game_refreshes, :games_refreshes
  end
end

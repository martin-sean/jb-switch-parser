class AddLinkToGames < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :link, :string
  end
end

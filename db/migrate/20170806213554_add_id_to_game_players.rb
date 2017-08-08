class AddIdToGamePlayers < ActiveRecord::Migration[5.1]
  def change
    add_reference :game_players, :team, foreign_key: true
  end
end

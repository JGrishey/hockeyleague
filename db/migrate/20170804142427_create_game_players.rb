class CreateGamePlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :game_players do |t|
      t.string :position
      t.timestamps
    end

    add_reference :game_players, :game
    add_reference :game_players, :user
  end
end

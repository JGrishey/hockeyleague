class AddGpIdToStatLines < ActiveRecord::Migration[5.1]
  def change
    add_reference :stat_lines, :game_player, foreign_key: true
  end
end

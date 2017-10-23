class CreateSeasonPlayerStats < ActiveRecord::Migration[5.0]
  def change
    create_view :season_player_stats
  end
end

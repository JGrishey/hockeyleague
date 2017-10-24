class UpdateSeasonPlayerStatsToVersion5 < ActiveRecord::Migration[5.0]
  def change
    update_view :season_player_stats, version: 5, revert_to_version: 4
  end
end

class UpdateSeasonPlayerStatsToVersion7 < ActiveRecord::Migration[5.0]
  def change
    update_view :season_player_stats, version: 7, revert_to_version: 6
  end
end

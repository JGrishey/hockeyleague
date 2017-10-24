class UpdateSeasonPlayerStatsToVersion4 < ActiveRecord::Migration[5.0]
  def change
    update_view :season_player_stats, version: 4, revert_to_version: 3
  end
end

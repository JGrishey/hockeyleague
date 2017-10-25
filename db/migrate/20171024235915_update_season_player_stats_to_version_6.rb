class UpdateSeasonPlayerStatsToVersion6 < ActiveRecord::Migration[5.0]
  def change
    update_view :season_player_stats, version: 6, revert_to_version: 5
  end
end

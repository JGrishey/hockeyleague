class CreateSeasonTeamStats < ActiveRecord::Migration[5.0]
  def change
    create_view :season_team_stats
  end
end

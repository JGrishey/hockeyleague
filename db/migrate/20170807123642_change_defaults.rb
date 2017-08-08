class ChangeDefaults < ActiveRecord::Migration[5.1]
  def change
      change_column :games, :home_ppo, :integer, default: 0
      change_column :games, :home_ppg, :integer, default: 0
      change_column :games, :home_toa_minutes, :integer, default: 0
      change_column :games, :home_toa_seconds, :integer, default: 0
      change_column :games, :away_ppo, :integer, default: 0
      change_column :games, :away_ppg, :integer, default: 0
      change_column :games, :away_toa_minutes, :integer, default: 0
      change_column :games, :away_toa_seconds, :integer, default: 0
      change_column :stat_lines, :position, :string, default: ""
      change_column :stat_lines, :plus_minus, :integer, default: 0
      change_column :stat_lines, :shots, :integer, default: 0
      change_column :stat_lines, :hits, :integer, default: 0
      change_column :stat_lines, :shots_against, :integer, default: 0
      change_column :stat_lines, :goals_against, :integer, default: 0
      change_column :stat_lines, :fow, :integer, default: 0
      change_column :stat_lines, :fot, :integer, default: 0
  end
end

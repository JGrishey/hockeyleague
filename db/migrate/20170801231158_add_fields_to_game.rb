class AddFieldsToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :home_toa_minutes, :integer
    add_column :games, :away_toa_minutes, :integer
    add_column :games, :home_toa_seconds, :integer
    add_column :games, :away_toa_seconds, :integer
    add_column :games, :home_ppg, :integer
    add_column :games, :away_ppg, :integer
    add_column :games, :home_ppo, :integer
    add_column :games, :away_ppo, :integer
  end
end

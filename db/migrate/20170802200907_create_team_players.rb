class CreateTeamPlayers < ActiveRecord::Migration[5.1]
  def change
    create_table :team_players do |t|

      t.timestamps
    end
  end
end

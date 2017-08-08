class AddForeignKeysToUsersAndTeams < ActiveRecord::Migration[5.1]
  def change
    add_reference :team_players, :user, foreign_key: true
    add_reference :team_players, :team, foreign_key: true
  end
end

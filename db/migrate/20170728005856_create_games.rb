class CreateGames < ActiveRecord::Migration[5.1]
  def change
    create_table :games do |t|
      t.integer :home_id
      t.integer :away_id
      t.datetime :date
      t.timestamps
    end

    add_reference :teams, :season, foreign_key: true
    add_reference :users, :team, foreign_key: true
    add_reference :teams, :user, foreign_key: true
  end
end

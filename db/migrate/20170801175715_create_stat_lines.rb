class CreateStatLines < ActiveRecord::Migration[5.1]
  def change
    create_table :stat_lines do |t|
      t.string :position
      t.integer :plus_minus
      t.integer :shots
      t.integer :fow
      t.integer :fot
      t.integer :hits
      t.integer :shots_against
      t.integer :goals_against
      t.timestamps
    end

    add_reference :stat_lines, :game, foreign_key: true
    add_reference :stat_lines, :user, foreign_key: true
    add_reference :stat_lines, :team, foreign_key: true
  end
end

class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :type
      t.timestamps
    end

    add_column :goals, :scorer_id, :integer
    add_index :goals, :scorer_id

    add_column :goals, :primary_id, :integer
    add_index :goals, :primary_id

    add_column :goals, :secondary_id, :integer
    add_index :goals, :secondary_id

    add_reference :goals, :game, foreign_key: true
    add_reference :goals, :team, foreign_key: true
  end
end

class CreatePenalties < ActiveRecord::Migration[5.1]
  def change
    create_table :penalties do |t|
      t.integer :duration
      t.timestamps
    end

    add_reference :penalties, :user, foreign_key: true
    add_reference :penalties, :team, foreign_key: true
    add_reference :penalties, :game, foreign_key: true
  end
end

class CreateMovements < ActiveRecord::Migration[5.1]
  def change
    create_table :movements do |t|

      t.timestamps
    end

    add_reference :movements, :trade, foreign_key: true
    add_reference :movements, :team_player, foreign_key: true
    add_reference :movements, :team, foreign_key: true
    add_column :trades, :pending, :boolean, default: true
    add_column :trades, :approved, :boolean, default: false
  end
end

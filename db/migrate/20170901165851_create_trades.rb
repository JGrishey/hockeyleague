class CreateTrades < ActiveRecord::Migration[5.1]
  def change
    create_table :trades do |t|

      t.timestamps
    end

    add_reference :trades, :season, foreign_key: true

    add_column :team_players, :salary, :integer, default: 0
    add_column :teams, :salary_cap, :integer, default: 0
  end
end

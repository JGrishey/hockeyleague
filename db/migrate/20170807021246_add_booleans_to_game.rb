class AddBooleansToGame < ActiveRecord::Migration[5.1]
  def change
    add_column :games, :final, :boolean, default: false
    add_column :games, :overtime, :boolean, default: false
  end
end

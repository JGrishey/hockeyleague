class AddVisibilityToTeam < ActiveRecord::Migration[5.1]
  def change
    add_column :teams, :visibility, :boolean, default: true
  end
end

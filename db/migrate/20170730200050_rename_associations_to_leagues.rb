class RenameAssociationsToLeagues < ActiveRecord::Migration[5.1]
  def change
    rename_table :associations, :leagues
  end
end

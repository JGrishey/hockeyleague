class RenameIDforSeasons < ActiveRecord::Migration[5.1]
  def change
    remove_column :seasons, :association_id
    add_reference :seasons, :league, foreign_key: true
  end
end

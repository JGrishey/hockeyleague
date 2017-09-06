class AddOriginIdToMovement < ActiveRecord::Migration[5.1]
  def change
    remove_column :movements, :team_id

    add_column :movements, :origin_id, :integer
    add_index :movements, :origin_id

    add_column :movements, :destination_id, :integer
    add_index :movements, :destination_id
  end
end

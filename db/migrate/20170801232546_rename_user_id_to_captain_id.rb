class RenameUserIdToCaptainId < ActiveRecord::Migration[5.1]
  def change
    remove_column :teams, :user_id

    add_column :teams, :captain_id, :integer
    add_index :teams, :captain_id
  end
end

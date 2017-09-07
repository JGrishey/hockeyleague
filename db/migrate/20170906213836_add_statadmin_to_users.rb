class AddStatadminToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :stat_admin, :boolean, default: false
  end
end

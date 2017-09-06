class AddDataToSignups < ActiveRecord::Migration[5.1]
  def change
    add_column :signups, :willing, :text, array: true, default: []
    add_column :signups, :preferred, :string, default: ""
    add_column :signups, :mia, :string, default: ""
    add_column :signups, :part_time, :boolean, default: false
    add_column :signups, :veteran, :boolean, default: true
  end
end

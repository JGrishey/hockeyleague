class AddSrcToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :src, :string, required: true
  end
end

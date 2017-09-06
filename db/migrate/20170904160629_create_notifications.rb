class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.string :body
      t.boolean :read, default: false
      t.timestamps
    end

    add_reference :notifications, :user, foreign_key: true
  end
end

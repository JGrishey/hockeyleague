class AddFieldsToUser < ActiveRecord::Migration[5.1]
  def self.up
    change_table :users do |t|
      t.attachment :avatar
      t.string :bio
    end
  end

  def self.down
    remove_attachment :users, :avatar
  end
end

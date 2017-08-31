class AddBiographicalFieldsToUser < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :bio
    add_column :users, :born, :datetime
    add_column :users, :height, :string
    add_column :users, :weight, :string
    add_column :users, :birthplace, :string
    add_column :users, :banner, :string
  end
end

class ChangeDateTimetoDate < ActiveRecord::Migration[5.1]
  def change
    change_column :users, :born, :date
  end
end

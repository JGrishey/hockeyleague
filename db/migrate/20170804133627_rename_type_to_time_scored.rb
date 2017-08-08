class RenameTypeToTimeScored < ActiveRecord::Migration[5.1]
  def change
    rename_column :goals, :type, :time_scored
  end
end

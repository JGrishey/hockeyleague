class AddFieldsToStatLines < ActiveRecord::Migration[5.1]
  def change
    add_column :stat_lines, :goals, :integer, default: 0
    add_column :stat_lines, :assists, :integer, default: 0
    add_column :stat_lines, :pim, :integer, default: 0
    add_column :stat_lines, :ppg, :integer, default: 0
    add_column :stat_lines, :shg, :integer, default: 0
  end
end

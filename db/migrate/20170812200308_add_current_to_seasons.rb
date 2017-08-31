class AddCurrentToSeasons < ActiveRecord::Migration[5.1]
  def change
    add_column :seasons, :current, :boolean, default: false
  end
end

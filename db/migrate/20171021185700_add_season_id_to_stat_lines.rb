class AddSeasonIdToStatLines < ActiveRecord::Migration[5.1]
  def change
    add_reference :stat_lines, :season, foreign_key: true
  end
end

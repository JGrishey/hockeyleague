class AddLogoToTeam < ActiveRecord::Migration[5.1]
  def change
    change_table :teams do |t|
      t.attachment :logo
    end
  end
end

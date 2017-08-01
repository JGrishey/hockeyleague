class CreateAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :associations do |t|
      t.string :name
      t.timestamps
    end

    add_reference :seasons, :association, foreign_key: true
  end
end

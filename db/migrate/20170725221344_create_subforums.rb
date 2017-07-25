class CreateSubforums < ActiveRecord::Migration[5.1]
  def change
    create_table :subforums do |t|
      t.text :title

      t.timestamps
    end

    add_reference :posts, :subforum, foreign_key: true
  end
end

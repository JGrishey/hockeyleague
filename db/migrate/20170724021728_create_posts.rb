class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :content
      t.timestamps
    end

    add_reference :posts, :user, foreign_key: true
  end
end

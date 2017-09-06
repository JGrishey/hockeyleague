class CreateSignups < ActiveRecord::Migration[5.1]
  def change
    create_table :signups do |t|

      t.timestamps
    end

    add_reference :signups, :user, foreign_key: true
    add_reference :signups, :season, foreign_key: true
  end
end

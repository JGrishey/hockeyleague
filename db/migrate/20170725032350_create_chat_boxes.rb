class CreateChatBoxes < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_boxes do |t|

      t.timestamps
    end
  end
end

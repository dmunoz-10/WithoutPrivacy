class CreateChatRooms < ActiveRecord::Migration[6.0]
  def change
    create_table :chat_rooms, id: :uuid do |t|
      t.string :user1_id
      t.string :user2_id

      t.timestamps
    end
    add_index :chat_rooms, :user1_id
    add_index :chat_rooms, :user2_id
  end
end

class CreateMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :messages, id: :uuid do |t|
      t.text :text, null: false
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.references :chat_room, null: false, foreign_key: true, type: :uuid
      t.datetime :seen_at
      t.datetime :deleted_at

      t.timestamps
    end
  end
end

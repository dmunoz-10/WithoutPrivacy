class CreateNotifications < ActiveRecord::Migration[6.0]
  def change
    create_table :notifications, id: :uuid do |t|
      t.string     :recipient_id
      t.string     :actor_id
      t.datetime   :seen_at
      t.string     :action
      t.references :notifiable, polymorphic: true, type: :uuid

      t.timestamps
    end
  end
end

# frozen_string_literal: true

# Message Model
class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom, class_name: 'ChatRoom', foreign_key: :chat_room_id

  validates :text, presence: true

  def seen!
    update(seen_at: Time.zone.now)
  end

  def delete!
    update(deleted_at: Time.zone.now)
  end
end

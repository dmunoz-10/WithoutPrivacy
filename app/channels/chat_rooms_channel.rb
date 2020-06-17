# frozen_string_literal: true

# ChatRooms Channel
class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_channel_#{params[:chat_room_id]}" unless params[:chat_room_id].nil?
  end

  def unsubscribed; end

  def seen(data)
    messages = ChatRoom.find(data['chat_room_id'])
                       .messages
                       .where.not(user: current_user)
                       .where(seen_at: nil)
    messages.map(&:seen!)
    ActionCable.server.broadcast "chat_rooms_channel_#{data['chat_room_id']}",
                                 type: 'seen', messages_id: messages.pluck(:id)
  end
end

# frozen_string_literal: true

# BroadcastChatRooms Job
class BroadcastChatRoomsJob < ApplicationJob
  queue_as :default

  def perform(current_user, type, message)
    if type == 'creation'
      ActionCable.server.broadcast "chat_rooms_channel_#{message.chat_room_id}",
                                   type: type, user: current_user.username,
                                   html_current_user: render_message(message, 'messages/message_current_user'),
                                   html_other_user: render_message(message, 'messages/message_other_user')
    else
      ActionCable.server.broadcast "chat_rooms_channel_#{message.chat_room_id}",
                                   type: type, message_id: message.id
    end
  end

  private

  def render_message(message, partial)
    ApplicationController.renderer.render partial: partial,
                                          locals: { message: message }, formats: :html
  end
end

# frozen_string_literal: true

# Messages Controller
class MessagesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_message, only: :destroy

  respond_to :js, :html, :json

  def create
    @message = authorize current_user.messages.new(message_params)
    if @message.save
      user = if @message.chatroom.user1 != current_user
               @message.chatroom.user1
             else
               @message.chatroom.user2
             end
      NotificationManager::Notifier.call current_user, 'talked', @message, user
      BroadcastChatRoomsJob.perform_later current_user, 'creation', @message
      head :ok
    end
  end

  def destroy
    if @message.delete!
      BroadcastChatRoomsJob.perform_later current_user, 'deleted', @message
      head :ok
    end
  end

  private

  def message_params
    params.require(:message).permit(:text, :chat_room_id)
  end

  def set_message
    @message = authorize Message.find(params[:id])
  end
end

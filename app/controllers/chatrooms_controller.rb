# frozen_string_literal: true

# ChatRooms Controller
class ChatroomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_chat_room
  before_action :mark_seen

  def index
    @message = @chatroom.messages.new
    @pagy, @messages = pagy(@chatroom.messages
                                     .order(created_at: :desc), link_extra: 'data-remote="true"')

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_chat_room
    @user = User.friendly.find(params[:id])
    raise Pundit::NotAuthorizedError if @user == current_user

    data = ChatRoom.between(current_user, @user)
    @chatroom = if data.empty?
                  ChatRoom.create(user1: current_user, user2: @user)
                else
                  data.take
                end
  end

  def mark_seen
    @notifications = current_user.notifications
                                 .where(notifiable_type: 'Message', actor: @user).not_seen
    @notifications.map(&:seen!) unless @notifications.empty?
  end
end

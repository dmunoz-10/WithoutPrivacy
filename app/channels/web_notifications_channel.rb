# frozen_string_literal: true

# WebNotifications Channel
class WebNotificationsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "WebNotifications:#{current_user.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end

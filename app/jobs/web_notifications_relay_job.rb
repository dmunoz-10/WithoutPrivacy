# frozen_string_literal: true

# WebNotifications Job
class WebNotificationsRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    count = notification.recipient.notifications.not_seen.count
    ActionCable.server.broadcast "WebNotifications:#{notification.recipient_id}",
                                 html: render_notification(notification), count: count,
                                 id: notification.id, action: notification.action
  end

  private

  def render_notification(notification)
    ApplicationController.render partial: 'web_notifications/index',
                                 locals: { notification: notification },
                                 formats: :html
  end
end

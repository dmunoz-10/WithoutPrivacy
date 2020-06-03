# frozen_string_literal: true

# WebNotifications Job
class WebNotificationsRelayJob < ApplicationJob
  queue_as :default

  def perform(notification)
    html = ApplicationController.render partial: 'web_notifications/index',
                                        locals: { notification: notification },
                                        formats: :html
    count = notification.recipient.notifications.not_seen.count
    ActionCable.server.broadcast "WebNotifications:#{notification.recipient_id}",
                                 html: html, count: count, id: notification.id
  end
end

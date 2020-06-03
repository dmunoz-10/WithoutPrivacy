# frozen_string_literal: true

# Notification Notifier
module NotificationManager
  class Notifier < ApplicationService
    def initialize(current_user, action, notifiable, recipient)
      @current_user = current_user
      @action = action
      @notifiable = notifiable
      @recipient = recipient
    end

    def call
      return if @current_user == @recipient

      notification = Notification.create(recipient: @recipient, actor: @current_user,
                                         action: @action, notifiable: @notifiable)
      WebNotificationsRelayJob.perform_later(notification)
    end
  end
end

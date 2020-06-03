# frozen_string_literal: true

# WebNotificationsMentioned Job
class WebNotificationsMentionedJob < ApplicationJob
  queue_as :default

  def perform(current_user, text, model)
    mentions = text.scan(/(?<=@)((?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29})+/).flatten
    mentions.each do |mention|
      user = User.friendly.find(mention)
      next if !user || user == current_user

      notification = Notification.create(recipient: user, actor: current_user,
                                         action: 'mentioned', notifiable: model)
      WebNotificationsRelayJob.perform_now notification
    end
  end
end

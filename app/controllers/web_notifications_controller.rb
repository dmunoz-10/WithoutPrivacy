# frozen_string_literal: true

# WebNotifications Controller
class WebNotificationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_notification, only: :seen
  before_action :set_notification_not_seen, except: :seen

  respond_to :js, :html, :json

  def index; end

  def seen
    @notification.seen!
    @notifications = current_user.notifications.not_seen
    render file: 'web_notifications/_notifications_list.js.erb'
  end

  def mark_seen_all
    @notifications.map(&:seen!)
    @notifications = current_user.notifications.not_seen
    render file: 'web_notifications/_notifications_list.js.erb'
  end

  private

  def set_notification
    @notification = Notification.find(params[:id])
  end

  def set_notification_not_seen
    @notifications = current_user.notifications.not_seen
  end
end

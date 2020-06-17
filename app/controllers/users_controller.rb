# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user
  before_action :mark_seen, only: :show

  rescue_from ActiveRecord::RecordNotFound, with: :content_not_found

  def show
    @pagy, @posts = pagy(@user.posts.order(created_at: :desc), items: 9,
                                                               link_extra: 'data-remote="true"')
    respond_to do |format|
      format.html
      format.js { render 'pages/pagination' }
    end
  end

  def follow
    current_user.follow @user
    NotificationManager::Notifier.call current_user, 'followed', current_user, @user
    redirect_to user_url(@user), notice: "You've followed @#{@user.username}"
  end

  def unfollow
    current_user.stop_following @user
    redirect_to user_url(@user), notice: "You've unfollowed @#{@user.username}"
  end

  def block
    current_user.stop_following(@user) if current_user.following?(@user)
    current_user.block @user
    redirect_to user_url(@user), notice: "You've blocked @#{@user.username}"
  end

  def unblock
    current_user.unblock @user
    redirect_to user_url(@user), notice: "You've unblocked @#{@user.username}"
  end

  def followers
    @users = @user.followers
    render :follows
  end

  def followings
    @users = @user.all_following
    render :follows
  end

  private

  def set_user
    @user = authorize User.friendly.find(params[:id])
  end

  def mark_seen
    @notifications = current_user.notifications.where(notifiable: @user).not_seen
    @notifications.map(&:seen!) unless @notifications.empty?
  end
end

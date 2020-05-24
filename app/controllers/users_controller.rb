# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  rescue_from ActiveRecord::RecordNotFound, with: :content_not_found

  def show; end

  def follow
    current_user.follow @user
    redirect_to user_url(@user), notice: "You've followed @#{@user.username}"
  end

  def unfollow
    current_user.stop_following @user
    redirect_to user_url(@user), notice: "You've unfollowed @#{@user.username}"
  end

  def block
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
end

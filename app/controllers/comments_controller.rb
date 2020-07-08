# frozen_string_literal: true

# Comments Controller
class CommentsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_comment, only: %i[destroy like users_liked]
  before_action :set_post

  respond_to :js, :html, :json

  def index
    @current_user = current_user if user_signed_in?
    @modal = params[:modal] != '0'
    @pagy, @comments = pagy(@post.comments.order(:created_at),
                            items: 12, link_extra: 'data-remote="true"')
  end

  def create
    @comment = authorize @post.comments.new(user: current_user, text: params[:text])
    @append = params[:append] == '1'
    if @comment.save
      NotificationManager::Notifier.call current_user, 'commented', @post, @post.user
      WebNotificationsMentionedJob.perform_later current_user, @comment.text, @post
    else
      redirect_to post_path(@post), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @comment.destroy
      render :destroy
    else
      redirect_to post_path(@post), alert: 'There was an error!'
    end
  end

  def like
    if current_user.voted_for? @comment
      @comment.unliked_by current_user
    else
      @comment.liked_by current_user
      NotificationManager::Notifier.call current_user, 'liked', @comment, @comment.user
    end
  end

  def users_liked
    @pagy, @users = pagy(@comment.voters, link_extra: 'data-remote="true"')
  end

  private

  def set_comment
    @comment = authorize Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end
end

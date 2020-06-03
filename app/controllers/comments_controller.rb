# frozen_string_literal: true

# Comments Controller
class CommentsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_comment, only: :destroy
  before_action :set_post

  respond_to :js, :html, :json

  def index
    @current_user = current_user if user_signed_in?
  end

  def create
    @comment = authorize @post.comments.new(user: current_user, text: params[:text])
    if @comment.save
      NotificationManager::Notifier.call current_user, 'commented', @post, @post.user
      WebNotificationsMentionedJob.perform_later current_user, @comment.text, @post
      render file: 'comments/_comments_list.js.erb'
    else
      redirect_to post_path(@post), alert: @comment.errors.full_messages.to_sentence
    end
  end

  def destroy
    if @comment.destroy
      render file: 'comments/_comments_list.js.erb'
    else
      redirect_to post_path(@post), alert: 'There was an error!'
    end
  end

  private

  def set_comment
    @comment = authorize Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
    @comments = @post.comments
  end
end

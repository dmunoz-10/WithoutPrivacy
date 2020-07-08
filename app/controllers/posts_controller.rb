# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :authenticate_user!, except: :users_liked
  before_action :set_post, except: %i[new create]
  before_action :mark_seen, only: :show

  respond_to :js, :html, :json

  rescue_from ActiveRecord::RecordNotFound, with: :content_not_found

  def new
    @post = authorize Post.new
  end

  def create
    @post = authorize current_user.posts.new(post_params)
    if @post.save
      unless @post.private?
        WebNotificationsMentionedJob.perform_later current_user, @post.description, @post
      end
      redirect_to post_url(@post), notice: 'Post created successfully!'
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def show
    @pagy, @comments = pagy(@post.comments, items: 12, link_extra: 'data-remote="true"')
  end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to post_url(@post), notice: 'Post updated successfully!'
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to user_url(@post.user), notice: 'Post deleted successfully!'
    else
      redirect_to :back, alert: 'There was an error!'
    end
  end

  def like
    if current_user.voted_for? @post
      @post.unliked_by current_user
    else
      @post.liked_by current_user
      NotificationManager::Notifier.call current_user, 'liked', @post, @post.user
    end
  end

  def users_liked
    @pagy, @users = pagy(@post.voters, link_extra: 'data-remote="true"')
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :private)
  end

  def set_post
    @post = authorize Post.find(params[:id])
  end

  def mark_seen
    @notifications = current_user.notifications.where(notifiable: @post).not_seen
    @notifications.map(&:seen!) unless @notifications.empty?
  end
end

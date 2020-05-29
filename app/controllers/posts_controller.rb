# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :authenticate_user!, except: :users_liked
  before_action :set_post, except: %i[new create]

  respond_to :js, :html, :json

  rescue_from ActiveRecord::RecordNotFound, with: :content_not_found

  def new
    @post = authorize Post.new
  end

  def create
    @post = authorize current_user.posts.new(post_params)
    if @post.save
      redirect_to post_url(@post), notice: 'Post created successfully!'
    else
      flash.now[:alert] = @post.errors.full_messages.to_sentence
      render :new
    end
  end

  def show; end

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
    end
  end

  def users_liked
    @users = @post.votes_for.up.by_type(User).voters
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :private)
  end

  def set_post
    @post = authorize Post.find(params[:id]), policy_class: PostPolicy
  end
end

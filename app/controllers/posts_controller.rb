# frozen_string_literal: true

# Posts Controller
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, except: %i[new create]

  rescue_from ActiveRecord::RecordNotFound, with: :content_not_found

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to user_url(@post.user), notice: 'Post created successfully!'
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new, alert: 'Error'
    end
  end

  def show; end

  def edit; end

  def update
    if @post.update(post_params)
      redirect_to user_url(@post.user), notice: 'Post updated successfully!'
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit, alert: 'Error'
    end
  end

  def destroy
    if @post.destroy
      redirect_to user_url(@post.user), notice: 'Post deleted successfully!'
    else
      flash.now[:errors] = @post.errors.full_messages
      redirect_to :back, alert: 'Error'
    end
  end

  private

  def post_params
    params.require(:post).permit(:description, :image, :private)
  end

  def set_post
    @post = Post.find(params[:id])
  end
end

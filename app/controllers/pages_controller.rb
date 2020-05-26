# frozen_string_literal: true

# Pages Controller
class PagesController < ApplicationController
  before_action :authenticate_user!, except: %i[home explorer terms_conditions privacy_policy]

  def home
    if user_signed_in?
      ids = current_user.all_following.pluck(:id)
      @posts = Post.where(user_id: ids)
                   .where.not(private: true)
                   .or(Post.where(user: current_user))
                   .order(created_at: :desc)
    end
  end

  def explorer
    @posts = Post.all.includes(:user).where.not('private', true).order(created_at: :desc)
  end

  def terms_conditions; end

  def privacy_policy; end
end

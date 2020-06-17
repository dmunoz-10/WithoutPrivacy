# frozen_string_literal: true

# Pages Controller
class PagesController < ApplicationController
  respond_to :js, :html, :json

  def home
    if user_signed_in?
      ids = current_user.all_following.pluck(:id)
      @pagy, @posts = pagy(Post.where(user_id: ids)
                               .where(private: false)
                               .or(Post.where(user: current_user))
                               .order(created_at: :desc),
                           items: 9, link_extra: 'data-remote="true"')
    end

    respond_to do |format|
      format.html
      format.js { render 'pagination' }
    end
  end

  def explorer
    @pagy, @posts = pagy(Post.all.includes(:user)
                             .where(private: false)
                             .order(created_at: :desc),
                         items: 9, link_extra: 'data-remote="true"')
    respond_to do |format|
      format.html
      format.js { render 'pagination' }
    end
  end

  def terms_service; end

  def privacy_policy; end
end

# frozen_string_literal: true

# Pages Controller
class PagesController < ApplicationController
  before_action :authenticate_user!, except: %i[home explorer]

  def home; end

  def explorer
    @posts = Post.all.includes(:user).where.not('private', true).order(created_at: :desc)
  end
end

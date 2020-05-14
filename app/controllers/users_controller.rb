# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  rescue_from ActiveRecord::RecordNotFound, with: :content_not_found

  def show; end

  private

  def set_user
    @user = User.friendly.find(params[:id])
  end
end

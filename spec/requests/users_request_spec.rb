# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    context 'when user exist' do
      it 'must show the user' do
        get user_path(user)
        expect(response).to render_template(:show)
      end
    end

    context 'when user does not exist' do
      it 'must not show the user' do
        get '/user_not_exist'
        expect(response).to be_not_found
      end
    end
  end

  describe 'GET #follow' do
    context 'when the current user is not following the user' do
      it 'must follow the user' do
        get follow_user_path(user2)

        expect(response).to redirect_to(user_path(user2))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq("You've followed @#{user2.username}")
      end
    end
  end

  describe 'GET #unfollow' do
    context 'when the current user already is following the user' do
      it 'must follow the user' do
        user.follow user2
        get unfollow_user_path(user2)

        expect(response).to redirect_to(user_path(user2))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq("You've unfollowed @#{user2.username}")
      end
    end
  end

  describe 'GET #block' do
    context 'when the current user has not blocked the user' do
      it 'must block the user' do
        get block_user_path(user2)

        expect(response).to redirect_to(user_path(user2))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq("You've blocked @#{user2.username}")
      end
    end
  end

  describe 'GET #unblock' do
    context 'when the current user already has blocked the user' do
      it 'must unblock the user' do
        user.block user2
        get unblock_user_path(user2)

        expect(response).to redirect_to(user_path(user2))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq("You've unblocked @#{user2.username}")
      end
    end
  end

  describe 'GET #followers' do
    context 'when the user has not blocked the current user' do
      it 'must render follows template' do
        get followers_user_path(user2), xhr: true

        expect(response).to be_successful
        expect(response.content_type).to eq('text/javascript; charset=utf-8')
        expect(response).to render_template(:follows)
      end
    end
  end

  describe 'GET #followings' do
    context 'when the user has not blocked the current user' do
      it 'must render follows template' do
        get followings_user_path(user2), xhr: true

        expect(response).to be_successful
        expect(response.content_type).to eq('text/javascript; charset=utf-8')
        expect(response).to render_template(:follows)
      end
    end
  end
end

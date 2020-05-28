# frozen_string_literal: true

require 'byebug'
require 'rails_helper'

RSpec.describe 'Comments', type: :request do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:post1) { create(:post, :public, user: user2) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'must show the comments of the post' do
      get post_comments_path(post1), xhr: true

      expect(response).to be_successful
      expect(response.content_type).to eq('text/javascript; charset=utf-8')
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    context 'when params are ok' do
      it 'must create the post' do
        params = { text: FFaker::Lorem.paragraph }

        post post_comments_path(post1), params: params, xhr: true

        expect(response).to be_successful
        expect(response.content_type).to eq('text/javascript; charset=utf-8')
      end
    end

    context 'when params are wrong' do
      it 'must not create the post' do
        params = { text: nil }

        post post_comments_path(post1), params: params, xhr: true

        expect(response).to redirect_to(post_path(post1))
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:comment) { create(:comment, user: user, post: post1) }

    context 'when everything is ok' do
      it 'must create the post' do
        delete post_comment_path(post1, comment), xhr: true

        expect(response).to be_successful
        expect(response.content_type).to eq('text/javascript; charset=utf-8')
      end
    end

    context 'when everything is wrong' do
      it 'must not create the post' do
        allow(Comment).to receive(:find).with(comment.id.to_s).and_return(comment)
        allow(comment).to receive(:destroy).and_return(false)

        delete post_comment_path(post1, comment), xhr: true

        expect(response).to redirect_to(post_path(post1))
        expect(flash[:alert]).to be_present
      end
    end
  end
end

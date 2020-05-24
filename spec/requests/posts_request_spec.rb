# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #new' do
    it 'must render new template' do
      get new_post_path

      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'when params are ok' do
      it 'must create the post' do
        params = { post: attributes_for(:post) }
        post posts_path, params: params

        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq('Post created successfully!')
      end
    end

    context 'when params are wrong' do
      it 'must not create the post' do
        params = { post: attributes_for(:post, description: nil) }
        post posts_path, params: params

        expect(response).to render_template(:new)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'Get #show' do
    context 'when post exists' do
      it 'must render show template' do
        post = create(:post, user: user)
        get post_path(post)

        expect(response).to render_template(:show)
      end
    end

    context 'when post does not exist' do
      it 'must render not found' do
        get '/p/post_not_found'

        expect(response).to be_not_found
      end
    end
  end

  describe 'GET #edit' do
    it 'must render edit template' do
      post = create(:post, user: user)
      get edit_post_path(post)

      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let!(:post) { create(:post, user: user) }

    context 'when params are ok' do
      it 'must update the post' do
        params = { post: attributes_for(:post) }
        put post_path(post), params: params

        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq('Post updated successfully!')
      end
    end

    context 'when params are wrong' do
      it 'must not update the post' do
        params = { post: attributes_for(:post, description: nil) }
        put post_path(post), params: params

        expect(response).to render_template(:edit)
        expect(flash[:alert]).to be_present
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:post) { create(:post, user: user) }

    context 'when everything is ok' do
      it 'must delete the post' do
        delete post_path(post)

        expect(response).to redirect_to(user_path(user))
        expect(flash[:notice]).to be_present
        expect(flash[:notice]).to eq('Post deleted successfully!')
      end
    end

    context 'when something is wrong' do
      it 'must not delete the post' do
        allow(Post).to receive(:find).with(post.id.to_s).and_return(post)
        allow(post).to receive(:destroy).and_return(false)

        delete post_path(post)

        expect(response).not_to be_successful
        expect(flash[:alert]).to eq('There was an error!')
      end
    end
  end
end

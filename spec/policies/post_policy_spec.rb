# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostPolicy, type: :policy do
  subject { described_class }

  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }

  permissions :new? do
    it 'grants access' do
      expect(subject).to permit(Post.new, user)
    end
  end

  permissions :create? do
    let!(:post) { build(:post, user: user) }

    it 'grants access' do
      expect(subject).to permit(user, post)
    end
  end

  permissions :show? do
    describe 'the user is not sign in' do
      context 'when the post is private' do
        let!(:post) { create(:post, :private, user: user2) }

        it 'denies access' do
          expect(subject).not_to permit(nil, post)
        end
      end

      context 'when the post is public' do
        let!(:post) { create(:post, :public, user: user2) }

        it 'grants access' do
          expect(subject).to permit(nil, post)
        end
      end
    end

    describe 'it is the post of the user' do
      let!(:post) { create(:post, user: user) }

      it 'grants access' do
        expect(subject).to permit(user, post)
      end
    end

    describe 'it is not the post of the user' do
      context 'when the post is private' do
        let!(:post) { create(:post, :private, user: user2) }

        it 'denies access' do
          expect(subject).not_to permit(user, post)
        end
      end

      context 'when the post is public' do
        let!(:post) { create(:post, :public, user: user2) }

        it 'grants access' do
          expect(subject).to permit(user, post)
        end
      end

      context 'the owner of the post has blocked the user' do
        let!(:post) { create(:post, user: user2) }

        it 'denies access' do
          user2.block user
          expect(subject).not_to permit(user, post)
        end
      end
    end
  end

  permissions :edit? do
    context 'when it is the post of the user' do
      let!(:post) { create(:post, user: user) }

      it 'grants access' do
        expect(subject).to permit(user, post)
      end
    end

    context 'when it is not the post of the user' do
      let!(:post) { create(:post, user: user2) }

      it 'denies access' do
        expect(subject).not_to permit(user, post)
      end
    end
  end

  permissions :update? do
    context 'when it is the post of the user' do
      let!(:post) { create(:post, user: user) }

      it 'grants access' do
        expect(subject).to permit(user, post)
      end
    end

    context 'when it is not the post of the user' do
      let!(:post) { create(:post, user: user2) }

      it 'denies access' do
        expect(subject).not_to permit(user, post)
      end
    end
  end

  permissions :destroy? do
    context 'when it is the post of the user' do
      let!(:post) { create(:post, user: user) }

      it 'grants access' do
        expect(subject).to permit(user, post)
      end
    end

    context 'when it is not the post of the user' do
      let!(:post) { create(:post, user: user2) }

      it 'denies access' do
        expect(subject).not_to permit(user, post)
      end
    end
  end

  permissions :like? do
    describe 'it is the post of the user' do
      let!(:post) { create(:post, user: user) }

      it 'grants access' do
        expect(subject).to permit(user, post)
      end
    end

    describe 'it is not the post of the user' do
      context 'when the post is private' do
        let!(:post) { create(:post, :private, user: user2) }

        it 'denies access' do
          expect(subject).not_to permit(user, post)
        end
      end

      context 'when the post is public' do
        let!(:post) { create(:post, :public, user: user2) }

        it 'grants access' do
          expect(subject).to permit(user, post)
        end
      end

      context 'the owner of the post has blocked the user' do
        let!(:post) { create(:post, user: user2) }

        it 'denies access' do
          user2.block user
          expect(subject).not_to permit(user, post)
        end
      end
    end
  end

  permissions :users_liked? do
    describe 'the user is not sign in' do
      context 'when the post is private' do
        let!(:post) { create(:post, :private, user: user2) }

        it 'denies access' do
          expect(subject).not_to permit(nil, post)
        end
      end

      context 'when the post is public' do
        let!(:post) { create(:post, :public, user: user2) }

        it 'grants access' do
          expect(subject).to permit(nil, post)
        end
      end
    end

    describe 'it is the post of the user' do
      let!(:post) { create(:post, user: user) }

      it 'grants access' do
        expect(subject).to permit(user, post)
      end
    end

    describe 'it is not the post of the user' do
      context 'when the post is private' do
        let!(:post) { create(:post, :private, user: user2) }

        it 'denies access' do
          expect(subject).not_to permit(user, post)
        end
      end

      context 'when the post is public' do
        let!(:post) { create(:post, :public, user: user2) }

        it 'grants access' do
          expect(subject).to permit(user, post)
        end
      end

      context 'the owner of the post has blocked the user' do
        let!(:post) { create(:post, user: user2) }

        it 'denies access' do
          user2.block user
          expect(subject).not_to permit(user, post)
        end
      end
    end
  end
end

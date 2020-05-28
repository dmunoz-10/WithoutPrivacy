# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CommentPolicy, type: :policy do
  subject { described_class }

  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:post) { create(:post, :public, user: user2) }

  permissions :index? do
    it 'grants access' do
      expect(subject).to permit(user, Comment.new)
    end
  end

  permissions :create? do
    let!(:comment) { build(:comment, user: user, post: post) }

    context 'when the owner of the post has blocked the user' do
      it 'denies access' do
        user2.block user

        expect(subject).not_to permit(user, comment)
      end
    end

    context 'when the owner of the post has not blocked the user' do
      it 'grants access' do
        expect(subject).to permit(user, comment)
      end
    end
  end

  permissions :destroy? do
    context 'when it is the comment of the user' do
      let!(:comment) { create(:comment, user: user, post: post) }

      it 'grants access' do
        expect(subject).to permit(user, comment)
      end
    end

    context 'when it is not the comment of the user' do
      let!(:comment) { create(:comment, user: user2, post: post) }

      it 'denies access' do
        expect(subject).not_to permit(user, comment)
      end
    end
  end
end

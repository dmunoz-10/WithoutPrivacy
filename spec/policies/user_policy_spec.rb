# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }

  permissions :show? do
    it 'grants access' do
      expect(subject).to permit(user, user2)
    end
  end

  permissions :follow? do
    context 'when the current user is following the user' do
      it 'denies access' do
        user.follow user2

        expect(subject).not_to permit(user, user2)
      end
    end

    context 'when the current user is not following the user' do
      it 'grants access' do
        expect(subject).to permit(user, user2)
      end
    end

    context 'when the current user is blocked by the user' do
      it 'denies access' do
        user2.block user

        expect(subject).not_to permit(user, user2)
      end
    end
  end

  permissions :unfollow? do
    context 'when the current user is following the user' do
      it 'grants access' do
        user.follow user2

        expect(subject).to permit(user, user2)
      end
    end

    context 'when the current user is not following the user' do
      it 'denies access' do
        expect(subject).not_to permit(user, user2)
      end
    end

    context 'when the current user is blocked by the user' do
      it 'denies access' do
        user2.block user

        expect(subject).not_to permit(user, user2)
      end
    end
  end

  permissions :block? do
    context 'when the current user has blocked the user' do
      it 'denies access' do
        user.block user2

        expect(subject).not_to permit(user, user2)
      end
    end

    context 'when the current user has not blocked the user' do
      it 'grants access' do
        expect(subject).to permit(user, user2)
      end
    end
  end

  permissions :unblock? do
    context 'when the current user has blocked the user' do
      it 'grants access' do
        user.block user2

        expect(subject).to permit(user, user2)
      end
    end

    context 'when the current user has not blocked the user' do
      it 'denies access' do
        expect(subject).not_to permit(user, user2)
      end
    end
  end

  permissions :followers? do
    context 'when the user has blocked the current user' do
      it 'denies access' do
        user2.block user

        expect(subject).not_to permit(user, user2)
      end
    end

    context 'when the user has not blocked the current user' do
      it 'grants access' do
        expect(subject).to permit(user, user2)
      end
    end
  end

  permissions :followings? do
    context 'when the user has blocked the current user' do
      it 'denies access' do
        user2.block user

        expect(subject).not_to permit(user, user2)
      end
    end

    context 'when the user has not blocked the current user' do
      it 'grants access' do
        expect(subject).to permit(user, user2)
      end
    end
  end
end

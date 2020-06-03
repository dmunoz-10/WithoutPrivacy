# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'Method seen!' do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let!(:post) { create(:post, :public, user: user) }
    let!(:notification) do
      create(:notification, recipient_id: user.id, actor_id: user2.id, action: 'liked',
                            notifiable: post)
    end

    it 'must update the field seen_at' do
      expect(notification.seen_at).to eq(nil)
      notification.seen!
      expect(notification.seen_at).not_to eq(nil)
    end
  end
end

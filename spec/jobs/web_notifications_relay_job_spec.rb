# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebNotificationsRelayJob, type: :job do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }
  let!(:post) { create(:post, :public, user: user) }
  let!(:notification) do
    create(:notification, recipient: user, actor: user2, action: 'liked',
                          notifiable: post)
  end

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe '#perform_later' do
    it 'create notifications to mentions users' do
      described_class.perform_later(notification)
      expect(described_class).to have_been_enqueued
    end
  end
end

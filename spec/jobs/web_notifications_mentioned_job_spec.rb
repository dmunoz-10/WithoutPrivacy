# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WebNotificationsMentionedJob, type: :job do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, :public, user: user) }

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  describe '#perform_later' do
    it 'create notifications to mentions users' do
      described_class.perform_later(user, post.description, post)
      expect(described_class).to have_been_enqueued
    end
  end
end

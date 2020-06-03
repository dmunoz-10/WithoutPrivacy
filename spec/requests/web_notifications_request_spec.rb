# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'WebNotifications', type: :request do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'must render index template' do
      get web_notifications_path, xhr: true

      expect(response).to be_successful
      expect(response.content_type).to eq('text/javascript; charset=utf-8')
      expect(response).to render_template(:index)
    end
  end

  describe 'PUT #seen' do
    let!(:user2) { create(:user) }
    let!(:post) { create(:post, :public, user: user2) }
    let!(:notification) do
      create(:notification, recipient_id: user2.id, actor_id: user.id, action: 'liked',
                            notifiable: post)
    end

    it 'must mark as seen the notification' do
      put seen_web_notification_path(notification), xhr: true

      expect(response).to be_successful
      expect(response.content_type).to eq('text/javascript; charset=utf-8')
    end
  end

  describe 'PUT #mark_seen_all' do
    it 'must mark as seen all notifications' do
      put mark_seen_all_web_notifications_path, xhr: true

      expect(response).to be_successful
      expect(response.content_type).to eq('text/javascript; charset=utf-8')
    end
  end
end

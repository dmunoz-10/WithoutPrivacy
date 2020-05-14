# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'Creating a user' do
    it 'must allow' do
      params = { user: attributes_for(:user) }
      post user_registration_path, params: params

      expect(response).to redirect_to(root_url)
    end
  end

  describe 'Sign in and out' do
    let!(:user) { create(:user) }

    it 'must allow' do
      sign_in user
      get user_path(user)
      expect(response).to render_template(:show)

      sign_out user
      get user_path(user)
      expect(response).not_to render_template(:show)
    end
  end
end

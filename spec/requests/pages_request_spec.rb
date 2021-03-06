# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #home' do
    it 'must render home template' do
      get root_path
      expect(response).to render_template(:home)
    end
  end

  describe 'GET #explorer' do
    it 'must render explorer template' do
      get explorer_path
      expect(response).to render_template(:explorer)
    end
  end

  describe 'GET #terms_service' do
    it 'must render terms service template' do
      get terms_service_path
      expect(response).to render_template(:terms_service)
    end
  end

  describe 'GET #privacy_policy' do
    it 'must render privacy policy template' do
      get privacy_policy_path
      expect(response).to render_template(:privacy_policy)
    end
  end
end

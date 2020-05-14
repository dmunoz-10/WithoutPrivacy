# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let!(:user) { create(:user) }

  before do
    sign_in user
  end

  describe 'GET #show' do
    context 'when user exist' do
      it 'must show the user' do
        get user_path(user)
        expect(response).to render_template(:show)
      end
    end

    context 'when user does not exist' do
      it 'must not show the user' do
        get '/user_not_exist'
        expect(response).to be_not_found
      end
    end
  end
end

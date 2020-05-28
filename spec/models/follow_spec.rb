# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Follow, type: :model do
  let!(:user) { create(:user) }
  let!(:user2) { create(:user) }

  describe 'block! method' do
    it 'must block the model' do
      user.follow user2
      follow = described_class.first
      follow.block!

      expect(follow.blocked).to eq(true)
    end
  end
end

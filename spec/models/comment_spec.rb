# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:post) { create(:post, :public, user: user) }

  describe 'Text validation' do
    it 'must exist' do
      comment = build(:comment, text: nil, user: user, post: post)
      comment.save
      expect(comment.errors[:text]).to include("can't be blank")
    end
  end
end

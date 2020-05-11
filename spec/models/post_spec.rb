# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'User validation' do
    it 'must exist' do
      post = build(:post)
      post.save
      expect(post.errors[:user]).to include('must exist')
    end
  end

  describe 'Description and image validation' do
    context 'when both are not present' do
      it 'must throw an error' do
        post = build(:post, user: create(:user), description: nil)
        post.save
        expect(post.errors[:base]).to include('Either image or description is required')
      end
    end
  end

  describe 'Private validation' do
    it 'must be false by default' do
      post = build(:post, user: create(:user), private: nil)
      post.valid?
      expect(post.private).to eq(false)
    end
  end
end

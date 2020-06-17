# frozen_string_literal: true

# ChatRoom Model
class ChatRoom < ApplicationRecord
  belongs_to :user1, class_name: 'User', foreign_key: :user1_id
  belongs_to :user2, class_name: 'User', foreign_key: :user2_id
  has_many :messages, dependent: :destroy

  scope :between, lambda { |user1, user2|
    where('(user1_id = ? AND user2_id = ?) OR (user1_id = ? AND user2_id = ?)',
          user1.id, user2.id, user2.id, user1.id)
  }
end

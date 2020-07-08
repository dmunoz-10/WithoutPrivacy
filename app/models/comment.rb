# frozen_string_literal: true

# Comment Model
class Comment < ApplicationRecord
  acts_as_votable

  belongs_to :post
  belongs_to :user
  has_many :voters, through: :votes_for, source_type: 'User'

  validates :text, presence: true
end

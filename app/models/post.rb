# frozen_string_literal: true

# Post Model
class Post < ApplicationRecord
  acts_as_votable

  before_validation { self.private ||= false }

  validate :presence_image_or_description
  validate :correct_image_type, if: -> { image.attached? }

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :notifications, as: :notifiable
  has_many :voters, through: :votes_for, source_type: 'User'

  has_one_attached :image

  private

  def correct_image_type
    unless image.content_type.in?(%w[image/jpeg image/png])
      errors.add(:image, 'must be jpeg or png')
    end
  end

  def presence_image_or_description
    if !image.attached? && description.blank?
      errors.add(:base, 'Either image or description is required')
    end
  end
end

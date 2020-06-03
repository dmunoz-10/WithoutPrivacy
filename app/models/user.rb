# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  extend FriendlyId
  friendly_id :username, use: :slugged

  acts_as_followable
  acts_as_follower
  acts_as_voter

  before_validation :downcase_username
  before_validation :downcase_email
  before_save :capitalize_name

  USERNAME_REGEXP = /\A(?!.*\.\.)(?!.*\.$)[^\W][\w.]{0,29}\z/.freeze

  enum gender: { male: 0, female: 1, rather_not_to_say: 2, other: 3 }

  validates :first_name, :last_name, :gender, :birth_date, presence: true
  validates :username, presence: true, uniqueness: true, format: { with: USERNAME_REGEXP }
  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp }
  validates :password, length: { minimum: 6 }, presence: true, on: :create

  has_one_attached :avatar

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, foreign_key: :recipient_id

  def avatar_thumbnail
    avatar.variant(resize_to_fill: [40, 40])
  end

  def avatar_display
    avatar.variant(resize_to_limit: [200, 200])
  end

  def blocked?(user)
    !followings.where(follower_id: user.id).where(blocked: true).empty?
  end

  private

  def downcase_username
    self.username = username.downcase if username.present?
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end

  def capitalize_name
    self.first_name = first_name.capitalize
    self.last_name = last_name.capitalize
  end
end

# frozen_string_literal: true

# User Model
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  before_validation :downcase_email

  enum gender: {
    male: 0,
    female: 1,
    rather_not_to_say: 2,
    other: 3
  }, _prefix: true

  validates :first_name, :last_name, :gender, :birth_date, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true, format: { with: Devise.email_regexp }
  validates :password, length: { minimum: 6 }, presence: true, on: :create

  has_one_attached :avatar

  has_many :post, dependent: :destroy

  def avatar_display
    avatar.variant(resize_to_limit: [200, 200])
  end

  def downcase_email
    self.email = email.downcase if email.present?
  end
end

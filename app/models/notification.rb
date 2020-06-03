# frozen_string_literal: true

class Notification < ApplicationRecord
  scope :not_seen, -> { where(seen_at: nil) }

  belongs_to :recipient, class_name: 'User'
  belongs_to :actor, class_name: 'User'
  belongs_to :notifiable, polymorphic: true

  def seen!
    update(seen_at: Time.zone.now)
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    recipient_id { nil }
    actor_id { nil }
    action { nil }
    seen_at { nil }
    notifiable { nil }
  end
end

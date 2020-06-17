# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    text { FFaker::Lorem.paragraph }
    user { nil }
    chatroom { nil }
    seen_at { nil }
    deleted_at { nil }
  end
end

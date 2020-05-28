# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    post { nil }
    user { nil }
    text { FFaker::Lorem.paragraph }
  end
end

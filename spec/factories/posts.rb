# frozen_string_literal: true

FactoryBot.define do
  factory :post do
    user { nil }
    description { FFaker::Lorem.paragraph }
    private { [true, false].sample }

    trait :private do
      private { true }
    end

    trait :public do
      private { false }
    end
  end
end

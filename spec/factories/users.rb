# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    username { FFaker::Internet.user_name }
    gender { User.genders.keys.sample }
    birth_date { FFaker::Time.date }
    email { FFaker::Internet.safe_email }
    password { '123456' }
    password_confirmation { '123456' }
  end
end

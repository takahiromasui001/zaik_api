# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "user#{n} " }
    email { 'email@example.com' }
    password { 'password' }
    password_confirmation { 'password' }
  end
end

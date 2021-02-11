# frozen_string_literal: true

FactoryBot.define do
  factory :storehouse do
    sequence(:name) { |n| "store#{n}" }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :stock do
    sequence(:name) { |n| "stock#{n}" }

    trait :with_storehouse do
      storehouse
    end
  end
end

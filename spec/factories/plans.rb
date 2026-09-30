FactoryBot.define do
  factory :plan do
    sequence(:name) { |n| "plan-#{n}" }
    target_type { "user" }
    price_cents { 0 }
    features_config { {} }

    trait :basic do
      name { "basic" }
    end
  end
end

FactoryBot.define do
  factory :event_requirement do
    event { nil }
    description { "MyText" }
    cost_cents { "9.99" }
    approved_by_user { false }
    approved_at { "2026-09-20 18:01:36" }
  end
end

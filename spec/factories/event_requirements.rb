FactoryBot.define do
  factory :event_requirement do
    event
    description { "Cambio de aceite" }
    cost_cents { 80000 }
    approved_by_user { false }
    approved_at { nil }
  end
end

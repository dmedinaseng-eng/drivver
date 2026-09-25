FactoryBot.define do
  factory :event do
    vehicle
    organization
    user
    event_type { "maintenance" }
    status { "open" }
    custody_flag { false }
    price_cents { 150000 }
  end
end

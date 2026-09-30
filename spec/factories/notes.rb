FactoryBot.define do
  factory :note do
    user
    organization
    association :notable, factory: :vehicle
    content { "Nota de seguimiento" }
    privacy_level { "private" }
  end
end

FactoryBot.define do
  factory :deal do
    vehicle
    organization
    association :client, factory: :user
    deal_type { "sale" }
    status { "open" }
  end
end

FactoryBot.define do
  factory :offer do
    deal
    organization
    association :offeror_user, factory: :user
    amount_cents { 25000000 }
    status { "pending" }
  end
end

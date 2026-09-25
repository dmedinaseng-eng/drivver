FactoryBot.define do
  factory :subscription do
    association :subscribable, factory: :user
    plan
    status { "active" }
    expires_at { 1.month.from_now.to_date }
  end
end

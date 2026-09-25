FactoryBot.define do
  factory :family_member do
    family
    user
    status { "active" }
    role { "admin" }
  end
end

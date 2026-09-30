FactoryBot.define do
  factory :entity_feature do
    feature
    association :featurable, factory: :plan
  end
end

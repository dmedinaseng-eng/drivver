FactoryBot.define do
  factory :plan do
    name { "MyString" }
    target_type { "MyString" }
    price_cents { "9.99" }
    features_config { "" }
  end
end

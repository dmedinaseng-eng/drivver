FactoryBot.define do
  factory :offer do
    deal { nil }
    offeror_user_id { "" }
    organization { nil }
    amount_cents { "9.99" }
    status { "MyString" }
  end
end

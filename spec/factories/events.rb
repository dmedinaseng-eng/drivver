FactoryBot.define do
  factory :event do
    vehicle { nil }
    organization { nil }
    user { nil }
    event_type { "MyString" }
    status { "MyString" }
    custody_flag { false }
    price_cents { "9.99" }
  end
end

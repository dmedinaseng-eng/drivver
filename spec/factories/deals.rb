FactoryBot.define do
  factory :deal do
    vehicle { nil }
    organization { nil }
    agent_seller_id { "" }
    client { nil }
    agent_buyer_id { "" }
    deal_type { "MyString" }
    status { "MyString" }
  end
end

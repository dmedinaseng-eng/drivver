FactoryBot.define do
  factory :note do
    user { nil }
    notable { nil }
    content { "MyText" }
    privacy_level { "MyString" }
    organization { nil }
  end
end

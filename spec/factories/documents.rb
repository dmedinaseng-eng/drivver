FactoryBot.define do
  factory :document do
    organization { nil }
    title { "MyString" }
    file_url { "MyText" }
    is_public { false }
    read_only_image { false }
  end
end

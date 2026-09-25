FactoryBot.define do
  factory :document do
    organization
    title { "Manual de usuario" }
    file_url { "https://example.com/doc.pdf" }
    is_public { false }
    read_only_image { false }
  end
end

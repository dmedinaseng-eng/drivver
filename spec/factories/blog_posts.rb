FactoryBot.define do
  factory :blog_post do
    organization { nil }
    author_id { "" }
    title { "MyString" }
    slug { "MyString" }
    content { "MyText" }
    meta_title { "MyString" }
    meta_description { "MyText" }
    schema_json { "" }
    status { "MyString" }
  end
end

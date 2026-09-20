FactoryBot.define do
  factory :blog_review do
    blog_post { nil }
    user { nil }
    rating { 1 }
    comment { "MyText" }
  end
end

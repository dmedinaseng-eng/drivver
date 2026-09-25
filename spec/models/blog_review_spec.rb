require "rails_helper"

RSpec.describe BlogReview, type: :model do
  subject { build(:blog_review) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:blog_post) }
  it { is_expected.to belong_to(:user) }
end

require "rails_helper"

RSpec.describe BlogPost, type: :model do
  subject { build(:blog_post) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:organization) }
  it { is_expected.to belong_to(:author).class_name("User") }
end

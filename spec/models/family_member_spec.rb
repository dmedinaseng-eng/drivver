require "rails_helper"

RSpec.describe FamilyMember, type: :model do
  subject { build(:family_member) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:family) }
  it { is_expected.to belong_to(:user) }
end

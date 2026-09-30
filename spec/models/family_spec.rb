require "rails_helper"

RSpec.describe Family, type: :model do
  subject { build(:family) }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:family_members).dependent(:destroy) }
  it { is_expected.to have_many(:users).through(:family_members) }
  it { is_expected.to have_many(:vehicles) }
end

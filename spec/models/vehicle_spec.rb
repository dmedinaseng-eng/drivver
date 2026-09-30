require "rails_helper"

RSpec.describe Vehicle, type: :model do
  subject { build(:vehicle) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:family).optional }
  it { is_expected.to validate_presence_of(:plate) }
  it { is_expected.to validate_uniqueness_of(:plate).case_insensitive }
end

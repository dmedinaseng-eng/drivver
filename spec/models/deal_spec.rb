require "rails_helper"

RSpec.describe Deal, type: :model do
  subject { build(:deal) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:vehicle) }
  it { is_expected.to belong_to(:organization).optional }
  it { is_expected.to belong_to(:client).class_name("User") }
end

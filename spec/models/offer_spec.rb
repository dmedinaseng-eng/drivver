require "rails_helper"

RSpec.describe Offer, type: :model do
  subject { build(:offer) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:deal) }
  it { is_expected.to belong_to(:organization).optional }
  it { is_expected.to belong_to(:offeror_user).class_name("User") }
end

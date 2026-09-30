require "rails_helper"

RSpec.describe Deal, type: :model do
  subject { build(:deal) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:vehicle) }
  it { is_expected.to belong_to(:organization) }
  it { is_expected.to belong_to(:client).class_name("User") }
  it { is_expected.to belong_to(:agent_seller).class_name("User").optional }
  it { is_expected.to belong_to(:agent_buyer).class_name("User").optional }
  it { is_expected.to have_many(:offers).dependent(:destroy) }
end

require "rails_helper"

RSpec.describe Subscription, type: :model do
  subject { build(:subscription) }

  it { is_expected.to be_valid }
  it { is_expected.to belong_to(:subscribable) }
  it { is_expected.to belong_to(:plan) }
end

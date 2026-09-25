require "rails_helper"

RSpec.describe Organization, type: :model do
  it { expect(build(:organization)).to be_valid }
end

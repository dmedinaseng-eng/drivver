require "rails_helper"

RSpec.describe Family, type: :model do
  it { expect(build(:family)).to be_valid }
end

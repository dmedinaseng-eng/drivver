require "rails_helper"

RSpec.describe "Drivver backoffice policies" do
  let(:policies) do
    [
      DrivverBackoffice::DashboardPolicy,
      DrivverBackoffice::UserPolicy,
      DrivverBackoffice::OrganizationPolicy,
      DrivverBackoffice::VehiclePolicy,
      DrivverBackoffice::DealPolicy,
      DrivverBackoffice::EventPolicy,
      DrivverBackoffice::BlogPostPolicy
    ]
  end

  it "allows every action for the internal team" do
    [ build(:user, :super_admin), build(:user, :developer), build(:user, :c_level) ].each do |user|
      policies.each do |policy_class|
        policy = policy_class.new(user, :record)
        expect(policy.index?).to be(true), policy_class.name
        expect(policy.show?).to be(true), policy_class.name
        expect(policy.create?).to be(true), policy_class.name
        expect(policy.update?).to be(true), policy_class.name
        expect(policy.destroy?).to be(true), policy_class.name
      end

      expect(DrivverBackoffice::UserPolicy.new(user, :record).toggle_active?).to be true
    end
  end

  it "denies standard users and guests" do
    [ build(:user), nil ].each do |user|
      policies.each do |policy_class|
        policy = policy_class.new(user, :record)
        expect(policy.show?).to be(false), policy_class.name
      end

      expect(DrivverBackoffice::UserPolicy.new(user, :record).toggle_active?).to be false
    end
  end
end

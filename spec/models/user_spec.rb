require "rails_helper"

RSpec.describe User, type: :model do
  subject { build(:user) }

  it { is_expected.to be_valid }
  it { is_expected.to have_many(:webauthn_credentials).dependent(:destroy) }
  it { is_expected.to have_many(:organization_roles).dependent(:destroy) }
  it { is_expected.to have_many(:organizations).through(:organization_roles) }
  it { is_expected.to have_many(:vehicles).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:family_members).dependent(:destroy) }
  it { is_expected.to have_many(:families).through(:family_members) }
  it { is_expected.to have_many(:subscriptions).dependent(:destroy) }
  it { is_expected.to have_many(:events).dependent(:restrict_with_error) }
  it { is_expected.to have_many(:notes).dependent(:destroy) }
  it { is_expected.to have_many(:blog_reviews).dependent(:destroy) }
  it { is_expected.to have_many(:deals).class_name("Deal").with_foreign_key("client_id").dependent(:destroy) }
  it { is_expected.to have_many(:sales_deals).class_name("Deal").with_foreign_key("agent_seller_id") }
  it { is_expected.to have_many(:purchase_deals).class_name("Deal").with_foreign_key("agent_buyer_id") }
  it { is_expected.to validate_presence_of(:email) }

  describe "#full_name" do
    it "concatenates first and last name" do
      user = build(:user, first_name: "Ana", last_name: "Pérez")
      expect(user.full_name).to eq("Ana Pérez")
    end
  end

  describe "#internal_team?" do
    it "is false for standard users" do
      expect(build(:user)).not_to be_internal_team
    end

    it "is true for super admins, developers and c-level" do
      expect(build(:user, :super_admin)).to be_internal_team
      expect(build(:user, :developer)).to be_internal_team
      expect(build(:user, :c_level)).to be_internal_team
    end
  end

  describe "operating context" do
    it "defaults new users to the personal context" do
      user = create(:user, current_context: nil)
      expect(user.current_context).to eq("personal")
      expect(user).to be_operating_in_personal_context
      expect(user).not_to be_operating_in_org_context
    end

    it "treats admin context as internal-only" do
      standard = create(:user, current_context: "admin")
      admin = create(:user, :super_admin, current_context: "admin")

      expect(standard).not_to be_operating_in_admin_context
      expect(admin).to be_operating_in_admin_context
    end

    it "resolves the active organization from the current context" do
      user = create(:user)
      org = create(:organization, :workshop)
      create(:organization_role, user: user, organization: org)
      user.update!(current_context: org.id)

      expect(user).to be_operating_in_org_context
      expect(user.active_organization).to eq(org)
      expect(user).to be_operating_in_workshop
    end
  end

  describe "#current_plan" do
    it "falls back to the basic plan" do
      plan = create(:plan, :basic)
      expect(create(:user).current_plan).to eq(plan)
    end

    it "returns the active subscription plan" do
      user = create(:user)
      plan = create(:plan, name: "pro")
      create(:subscription, subscribable: user, plan: plan, status: "active", expires_at: 1.week.from_now)
      expect(user.current_plan).to eq(plan)
    end
  end

  describe ".from_omniauth" do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: "google_oauth2",
        uid: "uid-123",
        info: { email: "ana@gmail.com", first_name: "Ana", last_name: "Pérez" }
      )
    end

    it "creates a user from Google data" do
      user = described_class.from_omniauth(auth)
      expect(user).to be_persisted
      expect(user.email).to eq("ana@gmail.com")
      expect(user.provider).to eq("google_oauth2")
      expect(user.uid).to eq("uid-123")
      expect(user.phone_country_code).to eq("CO")
    end

    it "reuses an existing user with the same email" do
      existing = create(:user, email: "ana@gmail.com")
      expect(described_class.from_omniauth(auth)).to eq(existing)
    end
  end

  describe ".from_google_payload" do
    it "creates a user from a verified payload" do
      user = described_class.from_google_payload(
        "sub" => "sub-1",
        "email" => "google@drivver.test",
        "email_verified" => true,
        "given_name" => "Luis",
        "family_name" => "Gómez"
      )
      expect(user).to be_persisted
      expect(user.first_name).to eq("Luis")
    end

    it "rejects unverified emails" do
      expect {
        described_class.from_google_payload("sub" => "x", "email" => "a@b.c", "email_verified" => false)
      }.to raise_error(ArgumentError, /not verified/)
    end
  end
end

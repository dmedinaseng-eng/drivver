require "rails_helper"

RSpec.describe "Google ID token sign-in", type: :request do
  let(:payload) do
    {
      "sub" => "google-sub-99",
      "email" => "one.tap@drivver.test",
      "email_verified" => true,
      "given_name" => "One",
      "family_name" => "Tap"
    }
  end

  before do
    allow(Google::Auth::IDTokens).to receive(:verify_oidc).and_return(payload)
  end

  it "signs in with a verified Google credential" do
    cookies["g_csrf_token"] = "csrf-token"

    expect {
      post users_google_id_token_path, params: { credential: "fake-jwt", g_csrf_token: "csrf-token" }
    }.to change(User, :count).by(1)

    expect(response).to redirect_to(os_root_path)
    expect(User.find_by(email: "one.tap@drivver.test")).to be_present
  end

  it "rejects an invalid Google token" do
    allow(Google::Auth::IDTokens).to receive(:verify_oidc)
      .and_raise(Google::Auth::IDTokens::VerificationError.new("bad token"))
    cookies["g_csrf_token"] = "csrf-token"

    post users_google_id_token_path, params: { credential: "bad", g_csrf_token: "csrf-token" }

    expect(response).to redirect_to(new_user_session_path)
    follow_redirect!
    expect(response.body).to include("No se pudo autenticar con Google")
  end
end

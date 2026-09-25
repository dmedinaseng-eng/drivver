require "rails_helper"

RSpec.describe "Passkeys", type: :request do
  describe "POST /users/passkeys/authenticate_options" do
    it "returns a webauthn challenge without signing in" do
      post authenticate_options_users_passkeys_path
      expect(response).to have_http_status(:ok)
      expect(response.parsed_body).to include("challenge")
    end
  end

  describe "GET /users/passkeys" do
    it "requires authentication" do
      get users_passkeys_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "POST /users/passkeys/authenticate" do
    it "rejects unknown credentials" do
      fake = instance_double(WebAuthn::PublicKeyCredentialWithAssertion, id: "unknown")
      allow(WebAuthn::Credential).to receive(:from_get).and_return(fake)

      post authenticate_users_passkeys_path, params: { credential: { id: "unknown" } }

      expect(response).to have_http_status(:not_found)
      expect(response.parsed_body["message"]).to include("no reconocido")
    end
  end
end

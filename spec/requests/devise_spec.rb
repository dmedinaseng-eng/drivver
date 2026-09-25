require "rails_helper"

RSpec.describe "Devise authentication", type: :request do
  describe "GET /users/sign_in" do
    it "renders Google auth and passkey entry points" do
      get new_user_session_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("google-auth")
      expect(response.body).to include("Passkey")
    end
  end

  describe "GET /users/sign_up" do
    it "renders Google auth and the email registration form" do
      get new_user_registration_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("google-auth")
      expect(response.body).to include("phone_country_code")
      expect(response.body).to include("Colombia")
    end
  end

  describe "POST /users" do
    it "creates an account with email and password" do
      expect {
        post user_registration_path, params: {
          user: {
            first_name: "Carlos",
            last_name: "Pérez",
            id_type: "CC",
            id_number: "1020304050",
            phone_country_code: "CO",
            phone_number: "3001234567",
            city: "Bogotá",
            email: "carlos@drivver.test",
            password: "password123",
            password_confirmation: "password123"
          }
        }
      }.to change(User, :count).by(1)

      expect(response).to redirect_to(os_root_path)
      follow_redirect!
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /users/sign_in" do
    it "authenticates with email and password" do
      user = create(:user, password: "password123")
      post user_session_path, params: { user: { email: user.email, password: "password123" } }
      expect(response).to redirect_to(os_root_path)
    end
  end
end

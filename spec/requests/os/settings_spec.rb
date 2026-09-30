require "rails_helper"

RSpec.describe "OS settings", type: :request do
  it "renders settings for a signed-in user" do
    user = create(:user)
    sign_in user
    get os_settings_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Configuración")
  end

  it "updates the profile without a password" do
    user = create(:user)
    sign_in user

    patch os_settings_path, params: { user: { first_name: "Camila", city: "Medellín" } }

    expect(response).to redirect_to(os_settings_path)
    expect(user.reload.first_name).to eq("Camila")
    expect(user.city).to eq("Medellín")
  end
end

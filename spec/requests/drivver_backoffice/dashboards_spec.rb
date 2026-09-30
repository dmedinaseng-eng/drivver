require "rails_helper"

RSpec.describe "Drivver backoffice dashboard", type: :request do
  it "redirects guests to sign in" do
    get drivver_backoffice_root_path
    expect(response).to redirect_to(new_user_session_path)
  end

  it "redirects users outside the internal team" do
    sign_in create(:user)
    get drivver_backoffice_root_path
    expect(response).to redirect_to(os_root_path)
    expect(flash[:alert]).to include("Acceso denegado")
  end

  it "signs out suspended internal users" do
    sign_in create(:user, :super_admin, :inactive)
    get drivver_backoffice_root_path
    expect(response).to redirect_to(root_path)
  end

  it "renders the growth charts for the internal team" do
    sign_in create(:user, :super_admin)
    get drivver_backoffice_root_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Crecimiento de Usuarios")
    expect(response.body).to include("Adquisición de Empresas")
    expect(response.body).to include("Registro de Vehículos")
    expect(response.body).to include("Comportamiento de Deals")
  end
end

require "rails_helper"

RSpec.describe "Drivver backoffice users", type: :request do
  let(:admin) { create(:user, :super_admin, first_name: "Ada", last_name: "Admin") }

  it "paginates the directory" do
    sign_in admin
    create_list(:user, 26)

    get drivver_backoffice_users_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Mostrando usuarios 1-25 de 27 en total")
    expect(response.body).to include("page=2")

    get drivver_backoffice_users_path(page: 2)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Mostrando usuarios 26-27 de 27 en total")
  end

  it "shows a user radiography" do
    sign_in admin
    member = create(:user, first_name: "Lucia", last_name: "Rojas")

    get drivver_backoffice_user_path(member)

    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Radiografía de Usuario")
    expect(response.body).to include("Lucia Rojas")
  end

  it "toggles the active flag" do
    sign_in admin
    member = create(:user, active: true)

    patch toggle_active_drivver_backoffice_user_path(member)

    expect(response).to redirect_to(drivver_backoffice_user_path(member))
    expect(member.reload).not_to be_active
    expect(flash[:notice]).to include("desactivada")

    patch toggle_active_drivver_backoffice_user_path(member)

    expect(member.reload).to be_active
  end

  it "rejects users outside the internal team" do
    sign_in create(:user)
    get drivver_backoffice_users_path
    expect(response).to redirect_to(os_root_path)
  end
end

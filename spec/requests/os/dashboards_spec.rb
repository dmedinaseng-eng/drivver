require "rails_helper"

RSpec.describe "OS dashboard", type: :request do
  it "redirects guests to sign in" do
    get os_root_path
    expect(response).to redirect_to(new_user_session_path)
  end

  it "renders for an active signed-in user" do
    user = create(:user)
    sign_in user
    get os_root_path
    expect(response).to have_http_status(:ok)
  end

  it "signs out suspended users" do
    user = create(:user, :inactive)
    sign_in user
    get os_root_path
    expect(response).to redirect_to(root_path)
  end
end

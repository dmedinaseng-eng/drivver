require "rails_helper"

RSpec.describe "Landing pages", type: :request do
  it "renders the sellers landing" do
    get root_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Vender mi vehículo")
  end

  it "renders the buyers landing" do
    get buyers_path
    expect(response).to have_http_status(:ok)
    expect(response.body).to include("Comprar carro")
  end
end

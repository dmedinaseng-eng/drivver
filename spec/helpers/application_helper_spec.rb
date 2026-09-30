require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#navbar_cta" do
    it "uses the sellers landing copy" do
      allow(helper).to receive(:controller).and_return(instance_double(ActionController::Base, action_name: "sellers"))
      expect(helper.navbar_cta).to eq("Vender mi vehículo")
    end

    it "uses the buyers landing copy" do
      allow(helper).to receive(:controller).and_return(instance_double(ActionController::Base, action_name: "buyers"))
      expect(helper.navbar_cta).to eq("Comprar carro")
    end

    it "falls back to Contáctanos on other public pages" do
      allow(helper).to receive(:controller).and_return(instance_double(ActionController::Base, action_name: "new"))
      expect(helper.navbar_cta).to eq("Contáctanos")
    end
  end

  describe "#l_datetime" do
    it "returns a dash when time is blank" do
      expect(helper.l_datetime(nil)).to eq("-")
    end
  end
end

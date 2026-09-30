require "rails_helper"

RSpec.describe OsHelper, type: :helper do
  let(:user) { create(:user, first_name: "Ana", last_name: "Pérez") }

  before do
    without_partial_double_verification do
      allow(helper).to receive(:current_user).and_return(user)
      allow(helper).to receive(:operating_as_internal_team?).and_return(false)
    end
  end

  describe "#current_context_ui" do
    it "builds the personal context for a new user" do
      ui = helper.current_context_ui
      expect(ui[:id]).to eq("personal")
      expect(ui[:name]).to eq("Ana Pérez")
      expect(ui[:emoji]).to eq("👤")
    end
  end

  describe "#os_navigation_items" do
    it "always includes home and settings" do
      menu = helper.os_navigation_items
      expect(menu[:main].first[:title]).to eq("Inicio")
      expect(menu[:system].map { |item| item[:path] }).to include(os_settings_path)
    end

    it "includes the personal garage in personal context" do
      titles = helper.os_navigation_items[:main].map { |item| item[:title] }
      expect(titles).to include("Mi Garaje")
    end
  end
end

class Os::DashboardsController < Os::ApplicationController
  def show
    authorize :dashboard, :show?
    @user = current_user
    set_whatsapp_cta
  end

  private
    def set_whatsapp_cta
      @whatsapp_number = ENV.fetch("WHATSAPP_NUMBER")
      @whatsapp_message = URI.encode_www_form_component("Hola, soy nuevo en Drivver. Me ayudas")
      @cta_url = "https://wa.me/#{@whatsapp_number}?text=#{@whatsapp_message}"
    end
end

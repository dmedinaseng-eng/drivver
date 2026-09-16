class LandingController < ApplicationController
  def sellers
    set_whatsapp_cta
  end

  def buyers
    set_whatsapp_cta
  end

  private
    def set_whatsapp_cta
      @whatsapp_number = ENV.fetch("WHATSAPP_NUMBER")
      @whatsapp_message = URI.encode_www_form_component(t("landing.#{action_name}.whatsapp_message"))
      @cta_url = "https://wa.me/#{@whatsapp_number}?text=#{@whatsapp_message}"
    end
end

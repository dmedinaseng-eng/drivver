class ApplicationController < ActionController::Base
  allow_browser versions: :modern
  stale_when_importmap_changes

  before_action :use_spanish_locale
  before_action :set_whatsapp_cta

  # Redirección tras iniciar sesión exitosamente
  def after_sign_in_path_for(resource)
    os_root_path
  end

  # Redirección tras cerrar sesión
  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

  private

  def use_spanish_locale
    I18n.locale = :es
  end

  def set_whatsapp_cta
    @whatsapp_number = ENV.fetch("WHATSAPP_NUMBER")
    @whatsapp_message = URI.encode_www_form_component(whatsapp_cta_message)
    @cta_url = "https://wa.me/#{@whatsapp_number}?text=#{@whatsapp_message}"
  end

  def whatsapp_cta_message
    t("navbar.public.whatsapp_message")
  end
end
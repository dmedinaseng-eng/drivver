class LandingController < ApplicationController
  def sellers
  end

  def buyers
  end

  private

  def whatsapp_cta_message
    t("landing.#{action_name}.whatsapp_message")
  end
end

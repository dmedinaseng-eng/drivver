module ApplicationHelper
  def landing_t(key, **options)
    t("landing.#{controller.action_name}.#{key}", **options)
  end

  def navbar_cta
    t("navbar.public.#{controller.action_name}.cta")
  end
end

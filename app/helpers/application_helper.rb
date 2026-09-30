module ApplicationHelper
  def landing_t(key, **options)
    t("landing.#{controller.action_name}.#{key}", **options)
  end

  def navbar_cta
    t("navbar.public.#{controller.action_name}.cta", default: t("navbar.public.cta"))
  end

  def time_ago_in_words_local(from_time)
    return "-" if from_time.blank?

    time_ago_in_words(from_time.in_time_zone)
  end

  def l_datetime(time, format: :short)
    return "-" if time.blank?

    local_time = time.in_time_zone

    case format
    when :short
      local_time.strftime("%d %b %Y - %H:%M")
    when :date_only
      local_time.strftime("%d/%m/%Y")
    when :time_only
      local_time.strftime("%H:%M")
    else
      l(local_time, format: format)
    end
  end
end

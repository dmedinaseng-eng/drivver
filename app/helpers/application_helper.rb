module ApplicationHelper
  def landing_t(key, **options)
    t("landing.#{controller.action_name}.#{key}", **options)
  end

  def navbar_cta
    t("navbar.public.#{controller.action_name}.cta", default: t("navbar.public.cta"))
  end

  COUNTRY_CODES = [
      [ "🇨🇴 (+57)", "57" ],
      [ "🇲🇽 (+52)", "52" ],
      [ "🇺🇸 (+1)", "1" ],
      [ "🇪🇸 (+34)", "34" ],
      [ "🇦🇷 (+54)", "54" ],
      [ "🇨🇱 (+56)", "56" ],
      [ "🇪🇨 (+593)", "593" ],
      [ "🇵🇪 (+51)", "51" ],
      [ "🇵🇦 (+507)", "507" ],
      [ "🇻🇪 (+58)", "58" ],
      [ "🇧🇷 (+55)", "55" ],
      [ "🇨🇷 (+506)", "506" ],
      [ "🇩🇴 (+1809)", "1809" ],
      [ "🇬🇹 (+502)", "502" ],
      [ "🇭🇳 (+504)", "504" ],
      [ "🇳🇮 (+505)", "505" ],
      [ "🇵🇾 (+595)", "595" ],
      [ "🇸🇻 (+503)", "503" ],
      [ "🇺🇾 (+598)", "598" ],
      [ "🇧🇴 (+591)", "591" ],
      [ "🇨🇦 (+1)", "1" ],
      [ "🇩🇪 (+49)", "49" ],
      [ "🇫🇷 (+33)", "33" ],
      [ "🇮🇹 (+39)", "39" ],
      [ "🇬🇧 (+44)", "44" ]
    ].freeze

    def country_code_options_for_select(selected_code = "57")
      options_for_select(COUNTRY_CODES, selected_code || "57")
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
        local_time.strftime("%d %b %Y - %H:%M")   # Ej: "28 Aug 2026 - 19:34"
      when :date_only
        local_time.strftime("%d/%m/%Y")           # Ej: "28/08/2026"
      when :time_only
        local_time.strftime("%H:%M")              # Ej: "19:34"
      else
        l(local_time, format: format)
      end
    end
end

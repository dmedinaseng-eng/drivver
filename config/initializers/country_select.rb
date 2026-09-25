ISO3166.configure do |config|
  config.locales = [ :es, :en ]
end

CountrySelect::FORMATS[:with_calling_code] = lambda do |country|
  name = country.translations[I18n.locale.to_s] || country.iso_short_name
  "#{country.emoji_flag} #{name} (+#{country.country_code})"
end

CountrySelect::DEFAULTS[:format] = :with_calling_code
CountrySelect::DEFAULTS[:locale] = :es
CountrySelect::DEFAULTS[:priority_countries] = %w[CO MX US ES AR PE CL EC]

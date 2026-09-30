source "https://rubygems.org"

# ===================================================================
# CORE DE RAILS & MOTOR DE BASE DE DATOS
# ===================================================================
gem "rails", "~> 8.1.3", ">= 8.1.3.1"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bootsnap", require: false
gem "thruster", require: false
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Pipeline de Assets y JS
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Adaptares de Solid (Cache, Queue, Cable)
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Serialización y utilidades
gem "jbuilder"
gem "json", "~> 2.13"
gem "friendly_id"

# ===================================================================
# AUTENTICACIÓN, OAUTH & AUTORIZACIÓN
# ===================================================================
gem "devise", "~> 5.0"
gem "omniauth"
gem "omniauth-google-oauth2"
gem "omniauth-rails_csrf_protection"
gem "googleauth"
gem "pundit"
gem "webauthn", "~> 3.4"

# ===================================================================
# INTERFAZ DE USUARIO, FORMULARIOS & DASHBOARDS
# ===================================================================
gem "tailwindcss-rails", "~> 4.6"
gem "simple_form"
gem "country_select"
gem "pagy"
gem "chartkick", "~> 5.2"
gem "groupdate", "~> 6.8"

# ===================================================================
# MÁQUINA DE ESTADOS & ALMACENAMIENTO (AWS S3 / ACTIVE STORAGE)
# ===================================================================
gem "aasm", "~> 6.0"
gem "aws-sdk-s3", "~> 1.232"
gem "image_processing", "~> 1.2"

# ===================================================================
# CONFIGURACIÓN DE ENTORNOS (DEVELOPMENT & TEST)
# ===================================================================
gem "dotenv-rails", groups: [ :development, :test ]

group :development, :test do
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "shoulda-matchers"
end

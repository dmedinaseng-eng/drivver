WebAuthn.configure do |config|
  # Nombre comercial que verá el usuario en la solicitud de Passkey
  config.rp_name = "Drivver OS"

  # En producción debe ser el dominio real sin puerto (ej. "drivver.com")
  # En desarrollo usamos localhost
  config.rp_id = Rails.env.production? ? "drivver.com" : "localhost"

  # Debe coincidir con window.location.origin
  config.allowed_origins = if Rails.env.production?
    [ "https://drivver.com" ]
  else
    [ "http://localhost:3000" ]
  end
end

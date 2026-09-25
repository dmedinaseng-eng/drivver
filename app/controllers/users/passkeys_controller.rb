module Users
    class PasskeysController < ApplicationController
      before_action :authenticate_user!, only: [ :index, :create, :callback, :destroy ]
      skip_before_action :verify_authenticity_token, only: [ :authenticate_options, :authenticate ]

      # Lista de Passkeys configuradas por el usuario autenticado
      def index
        @passkeys = current_user.webauthn_credentials
      end

      # 1. Generar opciones para REGISTRAR una nueva Passkey (Usuario Logueado)
      def create
        options = WebAuthn::Credential.options_for_create(
          user: {
            id: current_user.id,
            name: current_user.email,
            display_name: current_user.full_name
          },
          exclude: current_user.webauthn_credentials.pluck(:external_id)
        )

        session[:creation_challenge] = options.challenge

        render json: options
      end

      # 2. Guardar la nueva Passkey registrada tras la respuesta del navegador
      def callback
        webauthn_credential = WebAuthn::Credential.from_create(params[:credential])

        begin
          webauthn_credential.verify(session[:creation_challenge])

          credential = current_user.webauthn_credentials.build(
            external_id: webauthn_credential.id,
            public_key: webauthn_credential.public_key,
            sign_count: webauthn_credential.sign_count
          )

          if credential.save
            render json: { status: "ok", message: "Passkey vinculada con éxito." }
          else
            render json: { status: "error", errors: credential.errors.full_messages }, status: :unprocessable_entity
          end
        rescue WebAuthn::VerificationError => e
          render json: { status: "error", message: "Error de verificación: #{e.message}" }, status: :bad_request
        ensure
          session.delete(:creation_challenge)
        end
      end

      # 3. Generar opciones para AUTENTICAR / LOGIN con Passkey (Usuario No Logueado)
      def authenticate_options
        options = WebAuthn::Credential.options_for_get

        session[:authentication_challenge] = options.challenge

        render json: options
      end

      # 4. Validar firma biométrica e iniciar sesión de usuario
      def authenticate
        webauthn_credential = WebAuthn::Credential.from_get(params[:credential])

        stored_credential = WebauthnCredential.find_by(external_id: webauthn_credential.id)

        unless stored_credential
          return render json: { status: "error", message: "Dispositivo no reconocido." }, status: :not_found
        end

        begin
          webauthn_credential.verify(
            session[:authentication_challenge],
            public_key: stored_credential.public_key,
            sign_count: stored_credential.sign_count
          )

          stored_credential.update!(sign_count: webauthn_credential.sign_count)

          # Iniciar sesión de Devise
          sign_in(stored_credential.user)

          render json: { status: "ok", redirect_url: os_root_path }
        rescue WebAuthn::VerificationError => e
          render json: { status: "error", message: "Autenticación fallida: #{e.message}" }, status: :unauthorized
        ensure
          session.delete(:authentication_challenge)
        end
      end

      # Eliminar una Passkey vinculada
      def destroy
        passkey = current_user.webauthn_credentials.find(params[:id])
        passkey.destroy

        redirect_to users_passkeys_path, notice: "Passkey eliminada correctamente."
      end
    end
end

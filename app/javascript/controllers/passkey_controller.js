import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "error"]

  // Autenticarse con Passkey (Pantalla de Login)
  async authenticate(event) {
    event.preventDefault()
    this.clearError()

    if (!window.PublicKeyCredential) {
      this.showError("Tu navegador o dispositivo no soporta autenticación biométrica Passkeys.")
      return
    }

    try {
      // 1. Obtener challenge y opciones del servidor
      const optionsResponse = await fetch("/users/passkeys/authenticate_options", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.getCsrfToken()
        }
      })
      const options = await optionsResponse.json()

      // Convertir formatos Base64/Buffer para la API nativa del navegador
      options.challenge = this.base64ToBuffer(options.challenge)
      if (options.allowCredentials) {
        options.allowCredentials.forEach(cred => {
          cred.id = this.base64ToBuffer(cred.id)
        })
      }

      // 2. Invocar la API biométrica del dispositivo (FaceID / TouchID / PIN)
      const credential = await navigator.credentials.get({ publicKey: options })

      // 3. Enviar la firma generada al backend para iniciar sesión
      const authResponse = await fetch("/users/passkeys/authenticate", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.getCsrfToken()
        },
        body: JSON.stringify({ credential: this.credentialToJSON(credential) })
      })

      const result = await authResponse.json()

      if (authResponse.ok && result.status === "ok") {
        window.location.href = result.redirect_url
      } else {
        this.showError(result.message || "Error al autenticar con la Passkey.")
      }
    } catch (err) {
      if (err.name !== "NotAllowedError") {
        this.showError("Ocurrió un error en el sensor biométrico o la operación fue cancelada.")
      }
    }
  }

  // Registrar una nueva Passkey (Desde el panel de configuración del usuario)
  async register(event) {
    event.preventDefault()
    this.clearError()

    try {
      // 1. Obtener opciones de registro
      const optionsResponse = await fetch("/users/passkeys", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.getCsrfToken()
        }
      })
      const options = await optionsResponse.json()

      options.challenge = this.base64ToBuffer(options.challenge)
      options.user.id = this.stringToBuffer(options.user.id)

      // 2. Disparar creación de Passkey en el dispositivo
      const credential = await navigator.credentials.create({ publicKey: options })

      // 3. Guardar la clave pública en el servidor
      const saveResponse = await fetch("/users/passkeys/callback", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.getCsrfToken()
        },
        body: JSON.stringify({ credential: this.credentialToJSON(credential) })
      })

      const result = await saveResponse.json()

      if (saveResponse.ok && result.status === "ok") {
        window.location.reload()
      } else {
        this.showError(result.message || "No se pudo registrar la Passkey.")
      }
    } catch (err) {
      if (err.name !== "NotAllowedError") {
        this.showError("Error al registrar el dispositivo.")
      }
    }
  }

  // --- HELPERS DE TRANSFORMACIÓN DATA ---
  getCsrfToken() {
    return document.querySelector('meta[name="csrf-token"]')?.getAttribute("content")
  }

  showError(msg) {
    if (this.hasErrorTarget) {
      this.errorTarget.textContent = msg
      this.errorTarget.classList.remove("hidden")
    } else {
      alert(msg)
    }
  }

  clearError() {
    if (this.hasErrorTarget) {
      this.errorTarget.textContent = ""
      this.errorTarget.classList.add("hidden")
    }
  }

  base64ToBuffer(base64) {
    const pad = "=".repeat((4 - (base64.length % 4)) % 4)
    const base64Url = (base64 + pad).replace(/-/g, "+").replace(/_/g, "/")
    const rawData = window.atob(base64Url)
    const buffer = new Uint8Array(rawData.length)
    for (let i = 0; i < rawData.length; ++i) {
      buffer[i] = rawData.charCodeAt(i)
    }
    return buffer.buffer
  }

  stringToBuffer(str) {
    return new TextEncoder().encode(str)
  }

  bufferToBase64(buffer) {
    const bytes = new Uint8Array(buffer)
    let binary = ""
    for (let i = 0; i < bytes.byteLength; i++) {
      binary += String.fromCharCode(bytes[i])
    }
    return window.btoa(binary).replace(/\+/g, "-").replace(/\//g, "_").replace(/=/g, "")
  }

  credentialToJSON(credential) {
    const res = {
      id: credential.id,
      rawId: this.bufferToBase64(credential.rawId),
      type: credential.type,
      response: {}
    }

    if (credential.response.attestationObject) {
      res.response.attestationObject = this.bufferToBase64(credential.response.attestationObject)
    }
    if (credential.response.clientDataJSON) {
      res.response.clientDataJSON = this.bufferToBase64(credential.response.clientDataJSON)
    }
    if (credential.response.authenticatorData) {
      res.response.authenticatorData = this.bufferToBase64(credential.response.authenticatorData)
    }
    if (credential.response.signature) {
      res.response.signature = this.bufferToBase64(credential.response.signature)
    }
    if (credential.response.userHandle) {
      res.response.userHandle = this.bufferToBase64(credential.response.userHandle)
    }

    return res
  }
}
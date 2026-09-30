import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "fallback"]
  static values = {
    clientId: String,
    loginUri: String,
    csrfToken: String,
    context: { type: String, default: "signin" }
  }

  connect() {
    if (!this.hasUsableClientId) {
      this.showFallback()
      return
    }

    this.loadGsi()
      .then(() => this.initGsi())
      .catch(() => this.showFallback())
  }

  disconnect() {
    window.google?.accounts?.id?.cancel()
  }

  get hasUsableClientId() {
    const id = (this.clientIdValue || "").trim()
    return id.length > 0 && !id.includes("dummy") && !id.includes("tu_google")
  }

  loadGsi() {
    if (window.google?.accounts?.id) return Promise.resolve()

    return new Promise((resolve, reject) => {
      const existing = document.querySelector("script[data-google-gsi]")
      if (existing) {
        existing.addEventListener("load", () => resolve(), { once: true })
        existing.addEventListener("error", reject, { once: true })
        return
      }

      const script = document.createElement("script")
      script.src = "https://accounts.google.com/gsi/client"
      script.async = true
      script.defer = true
      script.dataset.googleGsi = "true"
      script.onload = () => resolve()
      script.onerror = reject
      document.head.appendChild(script)
    })
  }

  initGsi() {
    google.accounts.id.initialize({
      client_id: this.clientIdValue,
      ux_mode: "redirect",
      login_uri: this.loginUriValue,
      callback: (response) => this.handleCredential(response),
      auto_select: false,
      cancel_on_tap_outside: true,
      context: this.contextValue || "signin",
      itp_support: true,
      use_fedcm_for_button: true
    })

    if (this.hasButtonTarget) {
      google.accounts.id.renderButton(this.buttonTarget, {
        type: "standard",
        theme: "outline",
        size: "large",
        text: this.contextValue === "signup" ? "signup_with" : "continue_with",
        shape: "rectangular",
        width: Math.max(this.buttonTarget.offsetWidth || 320, 280),
        logo_alignment: "left"
      })
    }

    google.accounts.id.prompt()
  }

  async handleCredential(response) {
    try {
      const res = await fetch(this.loginUriValue, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Accept: "application/json",
          "X-CSRF-Token": this.csrfTokenValue
        },
        body: JSON.stringify({ credential: response.credential })
      })
      const data = await res.json()

      if (res.ok && data.redirect_url) {
        window.location.href = data.redirect_url
        return
      }
    } catch (_error) {
      // GIS One Tap failed; the redirect button remains available.
    }

    this.showFallback()
  }

  showFallback() {
    if (this.hasFallbackTarget) this.fallbackTarget.classList.remove("hidden")
  }
}

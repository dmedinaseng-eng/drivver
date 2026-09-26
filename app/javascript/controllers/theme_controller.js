import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { url: String, csrfToken: String }

  toggle(event) {
    const isDark = event.target.checked
    const theme = isDark ? "dark" : "light"

    // 1. Cambiar la clase en el HTML inmediatamente (Instant Feedback)
    const html = document.documentElement
    if (isDark) {
      html.classList.add("dark")
    } else {
      html.classList.remove("dark")
    }

    // 2. Guardar la preferencia en la Base de Datos sin recargar la página
    if (this.hasUrlValue) {
      fetch(this.urlValue, {
        method: "PATCH",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": this.csrfTokenValue,
          "Accept": "application/json" // Evita que Rails intente redirigir
        },
        body: JSON.stringify({ user: { theme: theme } })
      })
    }
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["container", "logoFull", "logoIcon", "itemText"]

  connect() {
    // Restaurar el estado guardado al cargar la página
    if (localStorage.getItem("sidebarCollapsed") === "true") {
      this.collapse(false) // false = sin transición suave inicial
    }
  }

  toggle() {
    if (this.isCollapsed) {
      this.expand()
    } else {
      this.collapse(true)
    }
  }

  get isCollapsed() {
    return this.containerTarget.classList.contains("md:w-20")
  }

  collapse(animate = true) {
    // 1. Reducir ancho del sidebar
    this.containerTarget.classList.remove("md:w-64")
    this.containerTarget.classList.add("md:w-20")

    // 2. Expandir el contenido principal (main-content)
    const mainContent = document.getElementById("main-content")
    if (mainContent) {
      if (!animate) mainContent.classList.remove("transition-all", "duration-300")
      mainContent.classList.remove("md:ml-64")
      mainContent.classList.add("md:ml-20")
      if (!animate) setTimeout(() => mainContent.classList.add("transition-all", "duration-300"), 50)
    }

    // 3. Ocultar logo completo, mostrar isotipo
    if (this.hasLogoFullTarget) this.logoFullTarget.classList.add("hidden")
    if (this.hasLogoIconTarget) this.logoIconTarget.classList.remove("hidden", "md:hidden")
    if (this.hasLogoIconTarget) this.logoIconTarget.classList.add("flex")

    // 4. Ocultar textos de los enlaces
    this.itemTextTargets.forEach(el => el.classList.add("hidden"))

    localStorage.setItem("sidebarCollapsed", "true")
  }

  expand() {
    // 1. Restaurar ancho del sidebar
    this.containerTarget.classList.remove("md:w-20")
    this.containerTarget.classList.add("md:w-64")

    // 2. Restaurar margen del contenido principal
    const mainContent = document.getElementById("main-content")
    if (mainContent) {
      mainContent.classList.remove("md:ml-20")
      mainContent.classList.add("md:ml-64")
    }

    // 3. Mostrar logo completo, ocultar isotipo
    if (this.hasLogoFullTarget) this.logoFullTarget.classList.remove("hidden")
    if (this.hasLogoIconTarget) this.logoIconTarget.classList.add("hidden")
    if (this.hasLogoIconTarget) this.logoIconTarget.classList.remove("flex")

    // 4. Mostrar textos de los enlaces
    this.itemTextTargets.forEach(el => el.classList.remove("hidden"))

    localStorage.setItem("sidebarCollapsed", "false")
  }
}
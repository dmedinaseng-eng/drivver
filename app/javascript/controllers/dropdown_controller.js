import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["menu", "openIcon", "closeIcon"]

  connect() {
    // Asegurarse de que esté cerrado al cargar
    this.close()
  }

  toggle(event) {
    if (event) {
      event.preventDefault()
      event.stopPropagation()
    }

    if (this.hasMenuTarget) {
      if (this.menuTarget.classList.contains("hidden")) {
        this.open()
      } else {
        this.close()
      }
    }
  }

  open() {
    if (this.hasMenuTarget) {
      this.menuTarget.classList.remove("hidden")
      this.menuTarget.classList.add("flex") // Mantiene la estructura flex-col
    }
    
    if (this.hasOpenIconTarget) this.openIconTarget.classList.add("hidden")
    if (this.hasCloseIconTarget) this.closeIconTarget.classList.remove("hidden")
  }

  close() {
    if (this.hasMenuTarget) {
      this.menuTarget.classList.add("hidden")
      this.menuTarget.classList.remove("flex")
    }
    
    if (this.hasOpenIconTarget) this.openIconTarget.classList.remove("hidden")
    if (this.hasCloseIconTarget) this.closeIconTarget.classList.add("hidden")
  }

  // Cierra el dropdown si se hace clic por fuera de él
  hideOnClickOutside(event) {
    if (!this.element.contains(event.target)) {
      this.close()
    }
  }
}
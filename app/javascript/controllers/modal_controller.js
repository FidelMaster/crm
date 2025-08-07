// app/javascript/controllers/modal_controller.js
import { Controller } from "@hotwired/stimulus"

// Se conecta a data-controller="modal"
export default class extends Controller {
  static targets = [ "container" ]

  // Abre el modal
  open() {
    this.containerTarget.classList.remove("hidden")
  }

  // Cierra el modal
  close() {
    this.containerTarget.classList.add("hidden")
  }

  // Permite cerrar el modal haciendo clic fuera de él
  handleBackdropClick(event) {
    if (this.containerTarget.contains(event.target) === false) {
      this.close()
    }
  }
}
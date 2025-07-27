import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['sidebar'];

  toggle() {
    this.sidebarTarget.classList.toggle('-translate-x-full');

    // Añade un overlay oscuro detrás del menú cuando se abre en móvil
    if (!this.sidebarTarget.classList.contains('-translate-x-full')) {
      const overlay = document.createElement('div');
      overlay.className = 'fixed inset-0 bg-black opacity-50 z-20 md:hidden';
      overlay.id = 'sidebar-overlay';
      overlay.dataset.action = 'click->sidebar#close';
      document.body.appendChild(overlay);
    } else {
      this.close();
    }
  }

  close() {
    this.sidebarTarget.classList.add('-translate-x-full');
    const overlay = document.getElementById('sidebar-overlay');
    if (overlay) {
      overlay.remove();
    }
  }
}

import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="navbar"
export default class extends Controller {
  static targets = ['adminMenu'];

  toggleAdminMenu() {
    this.adminMenuTarget.classList.toggle('hidden');
  }
}

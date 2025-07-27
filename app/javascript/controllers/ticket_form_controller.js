import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [
    'teamSelect',
    'serviceTypeSelect',
    'locationGroupSelect',
    'locationSelect',
  ];

  connect() {
    // Limpia los dropdowns dependientes al cargar por si el navegador autocompleta
    this.clearAndDisable(
      this.serviceTypeSelectTarget,
      'Selecciona un equipo primero',
    );
    this.clearAndDisable(
      this.locationSelectTarget,
      'Selecciona un grupo primero',
    );
  }

  teamChanged() {
    this.updateDropdown(
      this.teamSelectTarget.value,
      `/api/teams/${this.teamSelectTarget.value}/service_types`,
      this.serviceTypeSelectTarget,
      'Selecciona un tipo de servicio',
    );
  }

  locationGroupChanged() {
    this.updateDropdown(
      this.locationGroupSelectTarget.value,
      `/api/location_groups/${this.locationGroupSelectTarget.value}/locations`,
      this.locationSelectTarget,
      'Selecciona una ubicación',
    );
  }

  async updateDropdown(parentId, url, targetSelect, promptText) {
    if (!parentId) {
      this.clearAndDisable(targetSelect, promptText);
      return;
    }

    try {
      const response = await fetch(url);
      const data = await response.json();

      this.clearAndEnable(targetSelect, promptText);

      data.forEach((item) => {
        const option = new Option(item.description, item.id);
        targetSelect.add(option);
      });
    } catch (error) {
      console.error('Error fetching data:', error);
      this.clearAndDisable(targetSelect, 'Error al cargar');
    }
  }

  clearAndDisable(select, promptText) {
    select.innerHTML = `<option>${promptText}</option>`;
    select.disabled = true;
  }

  clearAndEnable(select, promptText) {
    select.innerHTML = `<option value="">${promptText}</option>`;
    select.disabled = false;
  }
}

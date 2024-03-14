import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ['history', 'selected']

  connect() {
  }

  clear(event) {
    event.preventDefault();
    this.historyTarget.innerHTML = '<h1>Empty yet...</h1>';
    this.selectedTarget.classList.remove('btn-success');
    this.selectedTarget.classList.add('btn-outline-success')
  }
}

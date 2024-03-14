import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="activity"
export default class extends Controller {
  static targets = ['details_buttons']
  connect() {
  }

  accept(event) {
    event.preventDefault();
    console.log('accepted!');
    console.log(this.details_buttonsTarget);
  }

}

import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="profile"
export default class extends Controller {
  static targets = ['selected', 'favorited', 'bookmarked']

  connect() {
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const status = urlParams.get('status');
    console.log(status);
    if (status === 'favorited') {
      this.favoritedTarget.classList.remove('btn-outline-warning');
      this.favoritedTarget.classList.add('btn-warning');
    } else if (status === 'bookmarked') {
      this.bookmarkedTarget.classList.remove('btn-outline-warning');
      this.bookmarkedTarget.classList.add('btn-warning');
    }else {
      this.selectedTarget.classList.remove('btn-outline-warning');
      this.selectedTarget.classList.add('btn-warning');
    }

  }

}

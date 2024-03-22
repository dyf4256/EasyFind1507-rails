import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="distance-filters"
export default class extends Controller {
  connect() {
  }

  update(event) {
    const url = this.element.action;
    const options = {
      method: "PATCH",
      headers: { "Accept": "application/json" },
      body: new FormData(this.element)
    };

    fetch(url, options)
      .then((response) =>  {
        if (response.status !== 204) {
          // TODO: Implement a better error handling that just a browser alert.
          alert("Something went wrong");
        }
        console.log(response.status);
      })
  }
}

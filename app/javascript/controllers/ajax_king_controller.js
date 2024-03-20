import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["meGusta"]

  connect() {
    console.log("AjaxKing controller connected");
    this.meGustaTargets.forEach(target => {
      console.log(target.dataset.favorited); // Log the initial favorited state
    });
  }

  switchLike(event) {
    event.preventDefault(); // Prevent the link from triggering a page reload

    const target = event.currentTarget;
    const heartIcon = target.querySelector("[data-ajax-king-target='meGusta']"); // Assuming the icon is a direct child

    fetch(target.href, {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector("[name='csrf-token']").getAttribute("content"),
        'Accept': 'application/json',
        'Content-Type': 'application/json'
      },
      credentials: 'include'
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.json();
    })
    .then(data => {
      if (data.favorited !== undefined) {
        this.revealContent(data.favorited, heartIcon);
      }
    })
    .catch(error => console.error("Error:", error));
  }


  revealContent(favorited, target) {
    target.dataset.favorited = favorited.toString();
    console.log("Before toggling:", target.classList.contains("text-danger"));
    if (favorited) {
      target.classList.add("text-danger");
    } else {
      target.classList.remove("text-danger");
    }
    console.log("After toggling:", target.classList.contains("text-danger"));
  }

}

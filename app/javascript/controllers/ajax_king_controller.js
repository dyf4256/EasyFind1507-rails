import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["meGusta"]

  connect() {
    console.log("AjaxKing controller connected");
  }

  switchLike(event) {
    event.preventDefault() // Prevent the link from triggering a page reload

    fetch(event.currentTarget.href, {
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
        throw new Error('Network response was not ok')
      }
      return response.json()
    })
    .then(data => {
      if (data.favorited !== undefined) {
        this.revealContent(data.favorited)
      }
    })
    .catch(error => console.error("Error:", error))
  }

  revealContent(favorited) {
    if (favorited) {
      this.meGustaTarget.classList.add("text-danger")
    } else {
      this.meGustaTarget.classList.remove("text-danger")
    }
  }
}

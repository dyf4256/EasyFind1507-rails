import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="friendly-text-change"
export default class extends Controller {
  connect() {
    const friendly_text = document.getElementById("friendly-text")

    const dialogChoice = ["How about you give this a try?", "Why not?", "Look at this cool one!", "You feeling this?", "Like the look of this?"]
    const random = Math.floor(Math.random() * dialogChoice.length);

    if (friendly_text.innerHTML === dialogChoice[random]) {
      const random2 = Math.floor(Math.random() * dialogChoice.length);
      friendly_text.innerHTML =  dialogChoice[random2]
    }
    friendly_text.innerHTML =  dialogChoice[random]
  }
}

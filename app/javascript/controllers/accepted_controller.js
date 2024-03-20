import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accepted"
export default class extends Controller {
  connect() {
    const end_text = document.getElementById("end-text")

    const dialogChoice = ["How about you give this a try?", "Why not try?", "Look at this cool one!", "You feeling this?", "Like the look of this?"]
    const random = Math.floor(Math.random() * dialogChoice.length);

    if (end_text.innerHTML === dialogChoice[random]) {
      const random2 = Math.floor(Math.random() * dialogChoice.length);
      end_text.innerHTML =  dialogChoice[random2]
    }
    end_text.innerHTML =  dialogChoice[random]
  }
}

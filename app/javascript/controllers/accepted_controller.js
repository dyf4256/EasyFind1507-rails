import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="accepted"
export default class extends Controller {
  connect() {
    const end_text = document.getElementById("end-text")

    const dialogChoice = ["Happy you liked this!", "I'll see you there!", "Knew you'd like this!", "You picked right!", "You got amazing taste!"]
    const random = Math.floor(Math.random() * dialogChoice.length);

    if (end_text.innerHTML === dialogChoice[random]) {
      const random2 = Math.floor(Math.random() * dialogChoice.length);
      end_text.innerHTML =  dialogChoice[random2]
    }
    end_text.innerHTML =  dialogChoice[random]
  }
}

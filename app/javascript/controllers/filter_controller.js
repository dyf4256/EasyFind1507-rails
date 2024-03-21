import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="filter"
export default class extends Controller {
  static targets = ['mainContainer','form']
  static values = {
    page: String,
    inputType: String
  };

  connect() {
  }

  fire(event){
    event.currentTarget.labels[0].classList.toggle('checked')
    const seletedElements = this.formTarget.querySelectorAll('input[type="checkbox"]:checked');
    let query = '?';
    seletedElements.forEach((element)=> {
      query += `${encodeURIComponent(element.name)}=${encodeURIComponent(element.value)}&`;
    })

    const url = this.formTarget.action + query;
    const options = {
      headers: { "Accept": "text/plain" }
    };

    fetch(url, options)
      .then(response => response.text())
      .then((data) =>{
        this.mainContainerTarget.outerHTML = data;
      })
  }
}

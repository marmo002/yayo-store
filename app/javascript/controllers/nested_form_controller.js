// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="hello">
//   <h1 data-target="hello.output"></h1>
// </div>

import { Controller } from "stimulus"

export default class extends Controller {

  connect() {
    console.log("contected to stimulus");
  }

  static targets = [ "add_item", "template" ]

  add_association(event) {
    event.preventDefault()

    var content = this.templateTarget.innerHTML

    if ( content.includes('TEMPLATE_RECORD') ) {

      content = content.replace(/TEMPLATE_RECORD/g, Math.floor(Math.random() * 20))

    } else if ( content.includes('TEMPLATE_SUB_RECORD') ) {

      content = content.replace(/TEMPLATE_SUB_RECORD/g, Math.floor(Math.random() * 20))
      
    }

    // var content = this.templateTarget.innerHTML.replace(/TEMPLATE_RECORD/g, Math.floor(Math.random() * 20))
    this.add_itemTarget.insertAdjacentHTML('beforebegin', content)
  }

  remove_association(event) {
    event.preventDefault()
    let item = event.target.closest('.nested-fields')
    item.querySelector("input[name*='_destroy']").value = 1
    item.style.display = 'none'
  }

}

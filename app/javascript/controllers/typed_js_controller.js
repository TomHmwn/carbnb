import { Controller } from "@hotwired/stimulus"
import Typed from "typed.js"

export default class extends Controller {
  connect() {
    new Typed(this.element, {
      strings: ["Find your car", "rent it", "and drive it"],
      typeSpeed: 50,
      loop: true
    })
  }
}

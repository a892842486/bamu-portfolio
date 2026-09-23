import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.toggleVisibility = this.toggleVisibility.bind(this)

    window.addEventListener("scroll", this.toggleVisibility)

    this.toggleVisibility()
  }

  disconnect() {
    window.removeEventListener("scroll", this.toggleVisibility)
  }

  toggleVisibility() {
    if (window.scrollY > 100) {
      this.element.classList.remove("hidden")
    } else {
      this.element.classList.add("hidden")
    }
  }

  scrollToTop() {
    window.scrollTo({
      top: 0,
      behavior: "smooth"
    })
  }
}
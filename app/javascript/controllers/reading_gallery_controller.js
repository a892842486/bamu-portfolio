import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["slide", "counter"]

  connect() {
    this.currentIndex = 0
    this.update()
  }

  previous() {
    this.currentIndex =
      (this.currentIndex - 1 + this.slideTargets.length) %
      this.slideTargets.length

    this.update()
  }

  next() {
    this.currentIndex =
      (this.currentIndex + 1) % this.slideTargets.length

    this.update()
  }

  update() {
    this.slideTargets.forEach((slide, index) => {
      slide.classList.toggle("hidden", index !== this.currentIndex)
      slide.classList.toggle("flex", index === this.currentIndex)
    })

    if (this.hasCounterTarget) {
      this.counterTarget.textContent =
        `${this.currentIndex + 1} / ${this.slideTargets.length}`
    }
  }
}
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const savedTheme = localStorage.getItem("theme")

    if (savedTheme === "dark") {
      document.documentElement.classList.add("dark")
    }
  }

  toggle() {
    const isDark = document.documentElement.classList.toggle("dark")

    localStorage.setItem("theme", isDark ? "dark" : "light")
  }
}

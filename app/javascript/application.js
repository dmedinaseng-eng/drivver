// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "chartkick"
import "Chart.bundle"

if (window.Chart) {
  const dark = document.documentElement.classList.contains("dark")
  window.Chart.defaults.color = dark ? "#CBD5E1" : "#334155"
  window.Chart.defaults.borderColor = dark ? "rgba(148, 163, 184, 0.2)" : "rgba(15, 23, 42, 0.08)"
}

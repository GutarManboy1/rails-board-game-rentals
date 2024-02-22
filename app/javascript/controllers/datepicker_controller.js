import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";
//import rangePlugin from "flatpickr/dist/plugins/rangePlugin";
// You need to import this to use new flatpickr()

export default class extends Controller {
  connect() {


    flatpickr(this.element, {
      // Provide an id for the plugin to work
      //plugins: [new rangePlugin({ input: "#booking_end_date"})]})
      mode: "range"

  })}
}

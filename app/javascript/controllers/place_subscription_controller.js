import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { placeId: Number, userId: Number }
  static targets = ["messages", "arrivalsAndDepartures"]

  resetForm(event) {
    event.target.reset()
  }

  connect() {
    this.subscription = createConsumer().subscriptions.create(
      { channel: "PlaceChannel", id: this.placeIdValue },
      { received: data => {
        if (data["message"] != null) {
          this.messagesTarget.insertAdjacentHTML("beforeend", data["message"]); 
        } else if (data["user_id"] != this.userIdValue) {
          console.log("arrival");
          this.arrivalsAndDeparturesTarget.insertAdjacentHTML("beforeend", data["arrival_or_departure"]);
        }
      }}
    )
    console.log(`subscribed to the place with id ${this.placeIdValue}.`)
    console.log(this.arrivalsAndDeparturesTarget);
  }
  
  disconnect() {
    console.log("unsubscribed from the place’s chatroom")
    this.subscription.unsubscribe()
  }
}
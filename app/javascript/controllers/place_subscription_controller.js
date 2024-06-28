import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { placeId: Number, userId: Number }
  static targets = ["messages"]

  resetForm(event) {
    event.target.reset()
  }

  connect() {
    this.subscription = createConsumer().subscriptions.create(
      { channel: "PlaceChannel", id: this.placeIdValue },
      { received: data => {
        console.log(data);
        if (data["message"] != null) {
          this.messagesTarget.insertAdjacentHTML("beforeend", data["message"]);
        } else if (data["arrival_or_departure"] != null && data["user_id"] != this.userIdValue) {
          this.messagesTarget.insertAdjacentHTML("beforeend", data["arrival_or_departure"]);
        } else if (data["outdoor_activity"] != null) {
          this.messagesTarget.insertAdjacentHTML("beforeend", data["outdoor_activity"]);
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
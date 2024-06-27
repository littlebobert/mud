import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { placeId: Number }
  static targets = ["messages"]

  connect() {
    this.subscription = createConsumer().subscriptions.create(
      { channel: "PlaceChannel", id: this.placeIdValue },
      { received: data => this.messagesTarget.insertAdjacentHTML("beforeend", data) }
    )
    console.log(`subscribed to the place with id ${this.placeIdValue}.`)
  }
  
  disconnect() {
    console.log("unsubscribed from the place’s chatroom")
    this.subscription.unsubscribe()
  }
}
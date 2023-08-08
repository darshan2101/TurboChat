import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    console.log("Connected");
    this.messages = document.getElementById("messages");

    this.mutationObserver = new MutationObserver(this.handleMutation);
    this.mutationObserver.observe(this.messages, { childList: true });

    this.resetScroll();
  }

  disconnect() {
    console.log("Disconnected");
    this.mutationObserver.disconnect();
  }

  handleMutation = () => {
    this.resetScroll();
  };

  resetScroll() {
    this.messages.scrollTop =
      this.messages.scrollHeight - this.messages.clientHeight;
  }
}

import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize() {
    this.resetScrollWithoutThreshold(messages);
  }
  connect() {
    console.log("Connected");
    this.messages = document.getElementById("messages");

    this.mutationObserver = new MutationObserver(this.handleMutation);
    this.mutationObserver.observe(this.messages, { childList: true });
  }

  disconnect() {
    console.log("Disconnected");
    this.mutationObserver.disconnect();
  }

  handleMutation = () => {
    this.resetScroll();
  };

  resetScroll() {
    const bottomOfScroll = messages.scrollHeight - messages.clientHeight;
    const upperScrollThreshold = bottomOfScroll - 500;
    if (this.messages.scrollTop - upperScrollThreshold) {
      this.resetScrollWithoutThreshold(this.messages);
    }
  }

  resetScrollWithoutThreshold(messages) {
    messages.scrollTop = messages.scrollHeight - messages.clientHeight;
  }
}

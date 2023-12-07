import { Controller } from "@hotwired/stimulus";
import { useIntersection } from "stimulus-use";

export default class AutoClick extends Controller {
	static messagesContainer;
	static topMessage;
	static throttling = false;
	connect() {
		console.log("AutoClick connected");
		useIntersection(this);
	}

	appear(entry, observer) {
		// callback automatically triggered when the element
		// intersects with the viewport (or root Element specified in the options)
		if (!AutoClick.throttling) {
			AutoClick.throttling = true;
			AutoClick.messagesContainer =
				document.getElementById("messages-container");
			AutoClick.topMessage = AutoClick.messagesContainer.children[0];
			AutoClick.throttle(this.element.click(), 300);

			setTimeout(() => {
				AutoClick.topMessage.scrollIntoView({
					behavior: "smooth",
					block: "end",
				});
				console.log("Scrolling");
				AutoClick.throttling = false;
			}, 250);
		}
	}

	disappear(entry, observer) {
		// callback automatically triggered when the element
		// leaves the viewport (or root Element specified in the options)
	}

	/**
	 * Throttle the click function.
	 * @param {Function} func The function to throttle.
	 * @param {Number} wait The time to wait before executing the function.
	 */

	static throttle(func, wait) {
		let timeout = null;
		let previous = 0;

		let later = function () {
			previous = Date.now();
			timeout = null;
			func();
		};

		return function () {
			let now = Date.now();
			let remaining = wait - (now - previous);

			if (remaining <= 0 || remaining > wait) {
				if (timeout) {
					clearTimeout(timeout);
				}
				later();
			} else if (!timeout) {
				timeout = setTimeout(later, remaining);
			}
		};
	}
}

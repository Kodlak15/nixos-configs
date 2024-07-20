import type { Cart } from "./types";
import { computeTotalCost } from "./utils";

export function toggleNavmenu() {
	var hamburger = document.getElementById("hamburger");
	var hamburgerTop = document.getElementById("hamburger-top");
	var hamburgerMid = document.getElementById("hamburger-mid");
	var hamburgerBot = document.getElementById("hamburger-bot");
	var navMenu = document.getElementById("navmenu");

	switch (hamburger?.classList.contains("open")) {
		case true: {
			hamburger.classList.remove("open");
			if (hamburgerTop !== null) {
				hamburgerTop.style.transform = "rotate(0)";
			}
			if (hamburgerMid !== null) {
				hamburgerMid.style.transform = "translateX(0)";
			}
			if (hamburgerBot !== null) {
				hamburgerBot.style.transform = "rotate(0)";
			}
			if (navMenu !== null) {
				navMenu.style.transform = "translateY(-100%)";
			}
			break;
		}
		case false: {
			hamburger.classList.add("open");
			if (hamburgerTop !== null) {
				hamburgerTop.style.transform = "rotate(45deg) translateY(20px)";
			}
			if (hamburgerMid !== null) {
				hamburgerMid.style.transform = "translateX(-100%)";
			}
			if (hamburgerBot !== null) {
				hamburgerBot.style.transform = "rotate(-45deg) translateY(-20px)";
			}
			if (navMenu !== null) {
				navMenu.style.transform = "translateY(0)";
			}
			break;
		}
	}
}

export function toggleCartPopup() {
	const cartPopup = document.getElementById("cart-popup");
	if (!cartPopup) {
		console.log("Error: No element with id 'cart-popup' found");
		return;
	}
	if (cartPopup.classList.contains("hidden")) {
		cartPopup.classList.remove("hidden");
	} else {
		cartPopup.classList.add("hidden");
	}
}

export function updateCartWidget(quantity: number) {
	const itemsInCart = document.getElementById("items-in-cart");
	if (!itemsInCart) {
		console.log("Unable to update UI: Missing items-in-cart widget");
		return;
	}

	itemsInCart.innerText = quantity.toString();
}

// TODO stupid stupid naming
// This should get the number of items for this product, not the total number
export function updateCartWidgetProduct(quantity: number, productId: string) {
	const spans = document.getElementsByClassName(
		"num-cart-items-" + productId,
	);

	for (let i = 0; i < spans.length; i++) {
		const span = spans[i] as HTMLElement;
		span.innerText = quantity.toString();
	}
}

export function updateCartSubtotal(cart: Cart) {
	const subtotal = computeTotalCost(cart);
	const element = document.getElementById("cart-subtotal");

	if (element && element.firstChild) {
		element.firstChild.textContent = "Subtotal: $" + subtotal.toString();
	}
}

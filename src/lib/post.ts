import { Incrementor, type Cart } from "./types";
import { updateCartSubtotal, updateCartWidget, updateCartWidgetProduct } from "./ui";
import { getProduct } from "./utils";

export async function updateCart(event: SubmitEvent, cart: Cart, productId: string, incrementor: Incrementor) {
	event.preventDefault();
	const form = event.currentTarget as HTMLFormElement;
	const formData = new FormData(form);

	try {
		const response = await fetch(form.action, {
			method: "POST",
			body: formData,
		});

		if (response.ok) {
			const result = await response.json();
			const json = JSON.parse(result.data);

			const quantityTotalIdx = json[0]["quantityTotal"];
			const quantityProductIdx = json[0]["quantityProduct"];
			const quantityTotal = JSON.parse(result.data)[quantityTotalIdx];
			const quantityProduct = JSON.parse(result.data)[quantityProductIdx];


			updateCartWidget(quantityTotal);
			updateCartWidgetProduct(quantityProduct, productId.toString());
			updateCartSubtotal(cart.map((item) => {
				if (item.productId === productId) {
					// TODO need to find a more convenient way to pass the list of products around
					// Also consider merging queries in main +layout.server.svelte file to improve performance a bit
					// const product = getProduct(item.productId);
					switch (incrementor) {
						case Incrementor.Inc: {
							if (item.quantity === 0) {
								const cartPopup = document.getElementById("cart-popup");
							}
							item.quantity = Math.min(item.quantity + 1, 20);
							break
						};
						case Incrementor.Dec: {
							item.quantity = Math.max(item.quantity - 1, 0);
							break
						};
					}
				}
				return item;
			}));
		} else {
			console.log("Failed to remove item from cart");
		}
	} catch (error) {
		console.error("Error:", error);
	}
}

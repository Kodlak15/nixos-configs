import { type CartItem } from "./types";
import { updateCartWidget, updateCartWidgetProduct } from "./ui";
import { cart } from "./stores";


export async function updateCart(event: SubmitEvent, productId: string) {
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

			cart.update((items) => {
				const existingItem: CartItem | undefined = items.find(
					(value) => value.productId === productId,
				);

				if (existingItem) {
					existingItem.quantity = quantityProduct;
				}

				return items;
			});

			updateCartWidget(quantityTotal);
			updateCartWidgetProduct(quantityProduct, productId.toString());
		} else {
			console.log("Failed to update the cart");
		}
	} catch (error) {
		console.error("Error:", error);
	}
}

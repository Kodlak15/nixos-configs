import { addToCart } from "$lib/server/shop";
import { getCurrentUser } from "$lib/server/user";
import { redirect, type Actions } from "@sveltejs/kit";

export const actions = {
	default: async ({ request, cookies }) => {
		const user = await getCurrentUser({ cookies });
		const userId = user?.id.toString();
		const urlParts = request.url.split("/");
		const productId = urlParts[urlParts.length - 1]

		try {
			if (userId) {
				addToCart(userId, productId);
			}
		} catch (error) {
			console.error("Failed to add item to cart:", error);
			return { success: false };
		}

		console.log("User", userId, "added product", productId, "to their cart")
	},
} satisfies Actions;

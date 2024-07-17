import { addToCart, removeFromCart } from "$lib/server/shop";
import { getCurrentUser } from "$lib/server/user";
import { type Actions } from "@sveltejs/kit";

export const actions = {
	addToCart: async ({ request, cookies }) => {
		const user = await getCurrentUser({ cookies });
		const userId = user?.id.toString();
		const urlParts = request.url.split("/");
		const productId = urlParts
			.map((part) => part.split("?")[0])
			.find((_, index, obj) => obj[index - 1] === "shop");

		if (!userId) return { success: false };
		if (!productId) return { success: false };

		try {
			addToCart(userId, productId);
		} catch (error) {
			return { success: false };
		}

		console.log("User", userId, "added product", productId, "to their cart")
	},
	removeFromCart: async ({ request, cookies }) => {
		const user = await getCurrentUser({ cookies });
		const userId = user?.id.toString();
		const urlParts = request.url.split("/");
		const productId = urlParts
			.map((part) => part.split("?")[0])
			.find((_, index, obj) => obj[index - 1] === "shop");

		if (!userId) return { success: false };
		if (!productId) return { success: false };

		try {
			removeFromCart(userId, productId);
		} catch (error) {
			return { success: false };
		}

		console.log("User", userId, "removed product", productId, "from their cart")
	},
} satisfies Actions;

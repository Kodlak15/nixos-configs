import { addToCart, removeFromCart } from "$lib/server/shop";
import { getNumCartItems, getNumProductItems } from "$lib/utils";
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
			const cart = await addToCart(userId, productId);
			if (!cart) return { success: false };

			const quantityTotal = getNumCartItems(cart);
			const quantityProduct = getNumProductItems(cart, productId);
			const response = {
				success: true,
				quantityTotal: quantityTotal,
				quantityProduct: quantityProduct,
				productId: productId,
			};
			return response;
		} catch (error) {
			return { success: false };
		}
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
			const cart = await removeFromCart(userId, productId);
			if (!cart) return { success: false };

			const quantityTotal = getNumCartItems(cart);
			const quantityProduct = getNumProductItems(cart, productId);
			const response = {
				success: true,
				quantityTotal: quantityTotal,
				quantityProduct: quantityProduct,
				productId: productId,
			};
			return response;
		} catch (error) {
			return { success: false };
		}
	},
} satisfies Actions;

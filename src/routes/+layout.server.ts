import { getCartItems, getProducts } from "$lib/server/shop";
import { getCurrentUser } from "$lib/server/user";
import type { LayoutServerLoad } from "./$types";

// Get data from the server that is needed upon page load
export const load: LayoutServerLoad = async ({ cookies }) => {
	// TODO since I am getting all of these at once, it would be cool to be able to return all of it from one query
	const user = await getCurrentUser({ cookies });
	const cart = user ? await getCartItems(user.id.toString()) : undefined;
	const products = await getProducts();

	return {
		user: user,
		cart: cart,
		products: products,
	};
};

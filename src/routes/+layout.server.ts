import { getCartItems } from "$lib/server/shop";
import { getCurrentUser } from "$lib/server/user";
import type { LayoutServerLoad } from "./$types";

// Get data from the server that is needed upon page load
export const load: LayoutServerLoad = async ({ cookies }) => {
	const user = await getCurrentUser({ cookies });

	if (user) {
		const cart = await getCartItems(user.id);

		return {
			// TODO why not return all (non-sensitive, ie. password) user info?
			firstName: user?.firstName,
			cart: cart,
		};
	}
};

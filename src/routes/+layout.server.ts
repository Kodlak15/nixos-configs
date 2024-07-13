import { getCartItems } from "$lib/server/shop";
import { getCurrentUser } from "$lib/server/user";
import type { LayoutServerLoad } from "./$types";

// Get data from the server that is needed upon page load
export const load: LayoutServerLoad = async ({ cookies }) => {
	const user = await getCurrentUser({ cookies });
	// const cartItems = await getCartItems(user?.id);

	return {
		firstName: user?.firstName, // TODO temporary
		// itemsInCart: cartItems?.length, // TODO temporary
	};
};

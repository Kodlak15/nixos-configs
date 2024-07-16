import { addToCart } from "$lib/server/shop";
import { getCurrentUser } from "$lib/server/user";
// import { redirect, type Actions } from "@sveltejs/kit";
import { type Actions } from "@sveltejs/kit";

// TODO the actions on this page are being performed, and buttons are set up to handle them
// The endpoints themselves, however, are borked af
// Need to also set up a way to create a cart for a user if one does not exist
// .............................. :{

export const actions = {
	addToCart: async ({ params, cookies }) => {
		const user = await getCurrentUser({ cookies });
		if (!user) {
			console.log("No user logged in")
			return;
		}

		const { productId } = params;
		if (productId) {
			await addToCart(user.id.toString(), productId);
		}

		// redirect(303, "/shop");
	},
} satisfies Actions;

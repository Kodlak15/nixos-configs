import { addToCart } from "$lib/server/shop";
import { getCurrentUser } from "$lib/server/user";
import { redirect, type Actions } from "@sveltejs/kit";

// TODO the actions on this page are being performed, and buttons are set up to handle them
// The endpoints themselves, however, are borked af
// Need to also set up a way to create a cart for a user if one does not exist
// .............................. :{

export const actions = {
	addToCart: async ({ request, cookies }) => {
		const user = await getCurrentUser({ cookies });
		if (!user) {
			console.log("No user logged in")
			return;
		}
		const data = await request.formData();
		// const productName = data.get("name") as string;
		const productName = "peppers"; // TODO temporary
		await addToCart(user.id, productName);
		// TODO is there a way I can trigger this action without needing to refresh the page?
		redirect(303, "/shop");
	},
} satisfies Actions;

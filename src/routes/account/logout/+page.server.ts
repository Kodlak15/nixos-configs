import { redirect } from "@sveltejs/kit";
import { type Actions } from "@sveltejs/kit";
import { logout } from "$lib/utils/user";

export const actions = {
	default: async (event) => {
		try {
			await logout(event);
		} catch (error) {
			console.error("Login failed:", error);
			return { success: false };
		}

		redirect(303, "/");
	},
} satisfies Actions;

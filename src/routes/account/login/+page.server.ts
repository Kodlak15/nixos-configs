import { redirect } from "@sveltejs/kit";
import type { Actions } from "./$types";
import { login } from "$lib/utils/user";

export const actions = {
	default: async (event) => {
		try {
			await login(event);
		} catch (error) {
			console.error("Login failed:", error);
			return { success: false };
		}

		redirect(303, "/");
	},
} satisfies Actions;

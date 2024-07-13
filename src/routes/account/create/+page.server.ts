import { redirect } from "@sveltejs/kit";
import type { Actions } from "./$types";
import { createUser } from "$lib/server/user";


export const actions = {
	default: async (event) => {
		try {
			await createUser(event);
		} catch (error) {
			console.error("Error adding user:", error);
			return { success: false };
		}

		throw redirect(303, "/account/login");
	},
} satisfies Actions;

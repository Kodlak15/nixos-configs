import { redirect } from "@sveltejs/kit";
import type { Actions } from "./$types";
import pkg from "pg";
const { Pool } = pkg;

const pool = new Pool({
	user: "postgres",
	host: "172.19.0.1",
	database: "cascade-botanicals",
	password: "example",
	port: 5432,
});

function query(text: string, params?: any[]) {
	return pool.query(text, params);
}

async function createUser({ request }: { request: Request }) {
	const formData = await request.formData();
	const username = formData.get("username") as string;
	const password = formData.get("password") as string;

	if (!username || !password) {
		throw new Error("Invalid form data");
	}

	await query("\
		INSERT INTO users (username, password)\
		VALUES ($1, $2)\
		", [username, password])
}

export const actions = {
	default: async (event) => {
		try {
			await createUser(event);
		} catch (error) {
			console.error("Error adding user:", error);
			return { success: false };
		}

		throw redirect(303, "/");
	},
} satisfies Actions;

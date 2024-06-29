import { redirect } from "@sveltejs/kit";
import type { Actions } from "./$types";
import pkg from "pg";
import dotenv from "dotenv";
const { Pool } = pkg;

// Load environment variables from .env
dotenv.config();

// Docker Postgres
// const pool = new Pool({
// 	user: "postgres",
// 	host: "172.19.0.1",
// 	database: "cascade-botanicals",
// 	password: "example",
// 	port: 5432,
// });

// Vercel Postgres
const pool = new Pool({
	connectionString: process.env.POSTGRES_URL,
});

function query(text: string, params?: any[]) {
	return pool.query(text, params);
}

interface User {
	username: string,
	password: string,
}

async function getUsers(): Promise<User[]> {
	const result = await query(`SELECT username, password FROM users`);
	return result.rows;
}

async function login({ request }: { request: Request }) {
	const users = await getUsers();
	const formData = await request.formData();
	const username = formData.get("username") as string;
	const password = formData.get("password") as string;

	for (var i = 0; i < users.length; i++) {
		const user = users[i];
		if (user.username === username && user.password === password) {
			return;
		}
	}

	throw new Error("Invalid username and/or password!");
}

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

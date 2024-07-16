import { type Cookies } from "@sveltejs/kit";
import { v4 as uuid } from "uuid";
import { pool } from "$lib/server/db";
import { checkPassword, hashPassword } from "./hash";

interface User {
	id: number,
	firstName: string,
	lastName: string,
	email: string,
};

export async function createUser({ request }: { request: Request }) {
	const formData = await request.formData();
	const firstName = formData.get("first_name");
	const lastName = formData.get("last_name");
	const email = formData.get("email") as string;
	const password = formData.get("password") as string;

	if (!firstName || !lastName || !email || !password) {
		throw new Error("Invalid form data");
	}

	const hash = await hashPassword(password);
	await pool.query(`
		INSERT INTO users (first_name, last_name, email, password)
		VALUES ($1, $2, $3, $4)
		`, [firstName, lastName, email, hash])
}

export async function getCurrentUser({ cookies }: { cookies: Cookies }): Promise<User | undefined> {
	const token = cookies.get("session");
	if (!token) {
		console.log("Get current user: No session cookie found");
		return;
	};

	const result = await pool.query(`
		SELECT Users.id, Users.first_name, Users.last_name, Users.email
		FROM Users
		INNER JOIN Sessions ON Users.id = Sessions.user_id
		WHERE token = $1
	`, [token]);

	if (result.rowCount && result.rowCount === 1) {
		const row = result.rows.pop();
		const user: User = {
			id: row.id,
			firstName: row.first_name,
			lastName: row.last_name,
			email: row.email,
		};
		return user;
	} else {
		console.log("Get current user: Invalid session token");
	}
}

// Create a new session for the given user ID
// Deletes any old session from sessions, adds a new row to sessions, and set a session cookie
async function newSession(userId: number, cookies: Cookies) {
	const token = uuid();
	const sessionMinutes = 24 * 60; // 1 day
	const userSessionLength = sessionMinutes * 60 * 1000; // length of user session in ms
	const expires = new Date(Date.now() + userSessionLength);

	await pool.query(`
		WITH deleted AS (
			DELETE FROM sessions
			WHERE user_id = $1
		)
		INSERT INTO sessions (token, user_id, expires_at)
		VALUES ($2, $1, $3)
	`, [userId, token, expires]);

	cookies.set("session", token, { path: "/", expires: expires });
}

export async function login({ request, cookies }: { request: Request, cookies: Cookies }) {
	const formData = await request.formData();
	const email = formData.get("email") as string;
	const password = formData.get("password") as string;

	const result = await pool.query(`
		SELECT id, password
		FROM Users
		WHERE email = $1
	`, [email]);

	if (result.rowCount && result.rowCount === 1) {
		const row = result.rows.pop();
		const hash = row.password;
		const isValidPassword = await checkPassword(password, hash);
		if (isValidPassword) {
			await newSession(row.id, cookies);
		} else {
			throw new Error("Invalid password!");
		}
	} else {
		console.log(email, "not found in users");
		throw new Error("Invalid email!");
	}
}

// Log out the current user
// Deletes the session cookie as well as the corresponding row from the sessions table
export async function logout({ cookies }: { cookies: Cookies }) {
	const token = cookies.get("session");

	await pool.query("\
		DELETE FROM sessions\
		WHERE token = $1\
	", [token]);

	cookies.delete("session", { path: "/" });
}


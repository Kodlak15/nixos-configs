import { type Cookies } from "@sveltejs/kit";
import { v4 as uuid } from "uuid";
import { pool } from "$lib/utils/db";

interface User {
	id: number,
	firstName: string,
	lastName: string,
	email: string,
	password: string,
}

interface Session {
	token: string,
	uid: number,
	expires: Date,
}

export async function getUser(uid: number): Promise<User> {
	const result = await pool.query("SELECT * FROM users WHERE id = $1", [uid])
	const row = result.rows.pop();
	const user: User = {
		id: row.id,
		firstName: row.first_name,
		lastName: row.last_name,
		email: row.email,
		password: row.password,
	}

	return user;
}

async function getAllUsers(): Promise<User[]> {
	const result = await pool.query(`SELECT * FROM users`);
	return result.rows;
}

async function getSessions(): Promise<Session[]> {
	const result = await pool.query("SELECT * FROM sessions");
	return result.rows;
}

export async function getActiveUser({ cookies }: { cookies: Cookies }): Promise<User | undefined> {
	const current_session = cookies.get("session");
	console.log("current session:", current_session)
	if (current_session === undefined) {
		return;
	}

	const sessions = await getSessions();
	for (let i = 0; i < sessions.length; i++) {
		const session = sessions[i];
		if (session.token === current_session) {
			const user = await getUser(session.uid);
			return user;
		}
	}
}

async function newSession(user: User, cookies: Cookies) {
	const sessionMinutes = 10;
	const userSessionLength = sessionMinutes * 60 * 1000; // length of user session in ms
	const token = uuid();
	const uid = user.id;
	const expires = new Date(Date.now() + userSessionLength);

	// Delete any existing session(s) for this uid
	await pool.query("\
		DELETE FROM sessions\
		WHERE uid = $1\
	", [uid]);

	// Add the new session to the sessions table
	await pool.query("\
		INSERT INTO sessions (token, uid, expires_at)\
		VALUES ($1, $2, $3)\
	", [token, uid, expires]);

	cookies.set("session", token, { path: "/", expires: expires });
}

export async function login({ request, cookies }: { request: Request, cookies: Cookies }) {
	const users = await getAllUsers();
	const formData = await request.formData();
	const email = formData.get("email") as string;
	const password = formData.get("password") as string;

	for (var i = 0; i < users.length; i++) {
		const user = users[i];
		if (user.email === email && user.password === password) {
			await newSession(user, cookies);
			return;
		}
	}

	throw new Error("Invalid email and/or password!");
}

// TODO
export async function logout({ request, cookies }: { request: Request, cookies: Cookies }) {
}

export async function createUser({ request }: { request: Request }) {
	const formData = await request.formData();
	const firstName = formData.get("first_name");
	const lastName = formData.get("last_name");
	const email = formData.get("email") as string;
	const password = formData.get("password") as string; // TODO hash me

	if (!firstName || !lastName || !email || !password) {
		throw new Error("Invalid form data");
	}

	await pool.query("\
		INSERT INTO users (first_name, last_name, email, password)\
		VALUES ($1, $2, $3, $4)\
		", [firstName, lastName, email, password])
}

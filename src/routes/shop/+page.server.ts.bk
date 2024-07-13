import { pool } from "$lib/utils/db";
import type { Actions } from "@sveltejs/kit";
import type { PageServerLoad } from "./$types";

interface Cart {
	id: string,
	uid: string,
	createdAt: string,
	updatedAt: string,
}

// Create a cart for a given uid
async function newCart(uid: string) {
	const now = new Date(Date.now());

	await pool.query("\
		INSERT INTO Carts (uid, created_at, updated_at)\
		VALUES ($1, $2, $3)\
	", [uid, now, now])
}

// TODO this could probably be tidied up a bit
async function getCart(uid: string): Promise<Cart | undefined> {
	const result = await pool.query("SELECT * FROM Carts WHERE id = $1", [uid])

	switch (result.rowCount) {
		case 0: {
			await newCart(uid);
			const row = result.rows.pop();
			const cart: Cart = {
				id: row.id,
				uid: row.uid,
				createdAt: row.created_at,
				updatedAt: row.updated_at,
			}

			return cart
		}
		case 1: {
			const row = result.rows.pop();
			const cart: Cart = {
				id: row.id,
				uid: row.uid,
				createdAt: row.created_at,
				updatedAt: row.updated_at,
			}

			return cart
		}
		default: { console.log("Error: there should never be more than one copy of a cart for a given uid"); }
	}
}

interface CartItem {
	id: string,
	cartId: string,
	productId: string,
	quantity: number,
	price: number,
}

async function itemsInCart(uid: string): Promise<number> {
	const cart = await getCart(uid);
	if (!cart) { return 0; }

	const result = await pool.query("SELECT * FROM CartItems WHERE cart_id = $1", [cart.id]);
	return result.rows
		.map((row) => row.quantity)
		.reduce((total, q) => total + q, 0);
}

async function addToCart() { }

async function removeFromCart() { }

export const load: PageServerLoad = async () => {
	return {
		itemsInCart: await itemsInCart("4"),
	};
}

export const actions = {
	// User triggered events should be handled here
} satisfies Actions;

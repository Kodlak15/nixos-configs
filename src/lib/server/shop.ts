import { pool } from "./db";

interface CartItem {
	cartId: string,
	productId: string,
	quantity: number,
	price: number,
}

// Get the cart items for the current active user
export async function getCartItems(uid: number | undefined): Promise<Array<CartItem> | undefined> {
	// TODO this just sucks
	if (!uid) {
		return;
	}

	const result = await pool.query(`
		SELECT CartItems.*
		FROM Users
		INNER JOIN Carts ON $1 = Carts.uid
		INNER JOIN CartItems ON Carts.id = CartItems.cart_id
	`, [uid]);

	return result.rows.map((row) => {
		const item: CartItem = {
			cartId: row.cart_id,
			productId: row.product_id,
			quantity: row.quantity,
			price: row.price_at_time_of_addition
		};

		return item;
	});
}

interface Product {
	id: number,
	name: string,
	description: string,
	price: number,
}

async function getProduct(productName: string): Promise<Product | undefined> {
	const result = await pool.query(`
		SELECT Products.price
		FROM Products
		WHERE Products.name = $1
	`, [productName]);

	if (result.rowCount === 0) {
		console.log("Product", productName, "not in database");
		return;
	}

	return result.rows.pop();
}

async function newCartItem(uid: number | undefined, productName: string): Promise<number | undefined> {
	if (!uid) { return; } // TODO this is shit

	const result = await pool.query(`
		INSERT INTO CartItems (cart_id, product_id, quantity, price_at_time_of_addition)
		INNER JOIN Carts on Carts.uid = $1
		INNER JOIN Products on Products.name = $2
		VALUES (Carts.id, Products.id, 0, Products.price)
		RETURNING id
	`, [uid, productName]);

	// TODO handle possible errors?
	const row = result.rows.pop();
	return row.id;
}

// Get the row id for the entry inside CartItems table for a given product and user
// If such a cart item does not already exist, creates a new one
async function getCartItemId(uid: number, productName: string): Promise<number | undefined> {
	const result = await pool.query(`
		SELECT CartItems.id
		FROM CartItems
		INNER JOIN Products ON CartItems.product_id = Products.id
		INNER JOIN Carts ON CartItems.cart_id = Carts.id
		INNER JOIN Users ON Carts.user_id = $1
		WHERE Products.name = $2
	`, [uid, productName]);

	switch (result.rowCount) {
		case 0: {
			return await newCartItem(uid, productName);
		};
		case 1: {
			const row = result.rows.pop();
			return row.id;
		};
		default: {
			console.log("Error: duplicate entry for", productName, "in cart for user with id", uid);
			return;
		};
	};
}

export async function addToCart(uid: number | undefined, productName: string) {
	console.log("HEY AT LEAST THIS IS GETTING CALLED YEAH?");

	if (!uid) { return; } // TODO this just sucks
	if (!productName) { return; } // TODO this just sucks

	const cartItemId = await getCartItemId(uid, productName);
	if (!cartItemId) { return; } // TODO better error handling

	// TODO error handling???
	await pool.query(`
		UPDATE CartItems		
		SET quantity = CartItems.quantity + 1
		WHERE id = $1
	`, [cartItemId]);
} 

import { pool } from "./db";

interface CartItem {
	productId: string,
	quantity: number,
	price: number,
}

// Get the cart items for the current active user
export async function getCartItems(userId: number): Promise<Array<CartItem> | undefined> {
	const result = await pool.query(`
		SELECT CartItems.product_id, CartItems.quantity, CartItems.price_at_time_of_addition as price
		FROM CartItems
		INNER JOIN Carts ON CartItems.cart_id = Carts.id
		INNER JOIN Users ON Carts.user_id = Users.id
		WHERE Users.id = $1
	`, [userId]);

	return result.rows.map((row) => {
		const item: CartItem = {
			productId: row.product_id,
			quantity: row.quantity,
			price: row.price,
		};

		return item;
	});
}

export async function addToCart(userId: string, productId: string) {
	// TODO for some reason this isn't working???
	console.log("Adding the thing to the cart");
	try {
		await pool.query(`
			WITH CreateCart AS (
				INSERT INTO Carts (user_id)
				VALUES ($1)
				ON CONFLICT DO NOTHING
			),
			Cart AS (
				SELECT Carts.id
				FROM Carts
				INNER JOIN Users ON Carts.user_id = Users.id
				WHERE Users.id = $1
			),
			ThisProduct AS (
				SELECT id, price, stock 
				FROM Products 
				WHERE id = $2
			)
			INSERT INTO CartItems (cart_id, product_id, quantity, price_at_time_of_addition)
			SELECT Cart.id, ThisProduct.id, 1, ThisProduct.price
			FROM Cart, ThisProduct
			ON CONFLICT (cart_id, product_id)
			DO UPDATE SET quantity = LEAST(20, CartItems.quantity + 1)
	`, [userId, productId]);
	} catch (error) {
		console.log("Error occurred while adding item to cart:", error);
		return;
	}
}

export async function removeFromCart(userId: string, productId: string) {
	try {

	} catch (error) {
		console.log("Error occurred while removing item from cart:", error);
		return;
	}
	await pool.query(`
		WITH Cart AS (
			SELECT Carts.id
			FROM Carts
			INNER JOIN Users ON Carts.user_id = Users.id
			WHERE Users.id = $1
		),
		ThisProduct AS (
			SELECT id, price
			FROM Products 
			WHERE id = $2
		)
		INSERT INTO CartItems (cart_id, product_id, quantity, price_at_time_of_addition)
		SELECT Cart.id, ThisProduct.id, 0, ThisProduct.price
		FROM Cart, ThisProduct
		ON CONFLICT (cart_id, product_id)
		DO UPDATE SET quantity = GREATEST(0, CartItems.quantity - 1)
	`, [userId, productId]);
} 

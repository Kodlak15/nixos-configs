import { pool } from "./db";

interface Product {
	id: number,
	name: string,
	description: string,
	price: number,
	stock: number,
	image: string,
}

interface CartItem {
	productId: string,
	quantity: number,
	price: number,
}

export async function getProducts(): Promise<Array<Product>> {
	const result = await pool.query(`
		SELECT * FROM Products
	`);

	return result.rows.map((row) => {
		const product: Product = {
			id: row.id,
			name: row.name,
			description: row.description,
			price: row.price,
			stock: row.stock,
			image: row.image,
		};

		return product;
	});
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
	// TODO set up this query such that it will not increase quantity beyond stock
	// May also be a good idea to pass back to UI so that the UI is always in sync with the server
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
	} catch (error) {
		console.log("Error occurred while removing item from cart:", error);
		return;
	}
}

export async function getNumCartItems(cart: Array<CartItem>): Promise<number> {
	return cart.reduce((total, item) => total + item.quantity, 0);
}

export async function computeTotalCost(cart: Array<CartItem>): Promise<number> {
	return cart.reduce((price, item) => price + (item.price * item.quantity), 0);
}

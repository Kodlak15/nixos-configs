import { pool } from "./db";

interface Product {
	id: number,
	name: string,
	description: string,
	price: number,
	stock: number,
	imageSrc: string,
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
			imageSrc: row.image,
		};

		return product;
	});
}

// Get the cart items for the current active user
export async function getCartItems(userId: string): Promise<Array<CartItem>> {
	const result = await pool.query(`
			SELECT *
			FROM CartItems
			INNER JOIN Carts ON CartItems.cart_id = Carts.id
			WHERE Carts.user_id = $1
		`, [userId]);

	return result.rows.map((row) => {
		const item: CartItem = {
			productId: row.product_id,
			quantity: row.quantity,
			price: row.price_at_time_of_addition,
		}
		return item;
	});
}

// Consider just returning the cart to make this more broadly useful
export async function addToCart(userId: string, productId: string): Promise<number | undefined> {
	try {
		// Query to update database
		await pool.query(`
			WITH Cart AS (
				INSERT INTO Carts (user_id)
				VALUES ($1)
				ON CONFLICT (user_id) 
				DO UPDATE
				SET user_id = EXCLUDED.user_id
				RETURNING id
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
			DO UPDATE 
			SET quantity = LEAST(CartItems.quantity + 1, (
				SELECT stock
				FROM Products
				WHERE id = CartItems.product_id
			))
	`, [userId, productId]);

		// TODO would be better to not have to make a separate query to get udpated cart items
		const cart = await getCartItems(userId);
		return getNumCartItems(cart);
	} catch (error) {
		console.log("Error occurred while adding item to cart:", error);
		return;
	}
}

// Consider just returning the cart to make this more broadly useful
export async function removeFromCart(userId: string, productId: string): Promise<number | undefined> {
	try {
		// Query to update database
		await pool.query(`
			WITH Cart AS (
				INSERT INTO Carts (user_id)
				VALUES ($1)
				ON CONFLICT (user_id) 
				DO UPDATE
				SET user_id = EXCLUDED.user_id
				RETURNING id
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
			DO UPDATE 
			SET quantity = GREATEST(CartItems.quantity - 1, 0)
	`, [userId, productId]);

		// TODO would be better to not have to make a separate query to get udpated cart items
		const cart = await getCartItems(userId);
		return getNumCartItems(cart);
	} catch (error) {
		console.log("Error occurred while adding item to cart:", error);
		return;
	}
}

export async function getNumCartItems(cart: Array<CartItem>): Promise<number> {
	return cart.reduce((total, item) => total + item.quantity, 0);
}

export async function computeTotalCost(cart: Array<CartItem>): Promise<number> {
	return cart.reduce((price, item) => price + (item.price * item.quantity), 0);
}

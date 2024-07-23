import { derived, writable, type Writable, type Readable } from "svelte/store";
import type { User, Cart, Product } from "./types";

export const user: Writable<User | undefined> = writable();
export const cart: Writable<Cart> = writable();
export const products: Writable<Array<Product>> = writable();

export const numItemsInCart: Readable<number> = derived(cart, $cart => {
	return $cart.reduce((total, item) => total + item.quantity, 0);
});

export const cartSubtotal: Readable<number> = derived(cart, ($cart) => {
	return $cart.reduce((price, item) => price + (item.price * item.quantity), 0);
});

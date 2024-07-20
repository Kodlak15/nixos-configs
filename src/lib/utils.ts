import type { Cart, CartItem, Product } from "./types";
import { productImages } from "./images";

export function getNumCartItems(cart: Cart): number {
	return cart.reduce((total, item) => total + item.quantity, 0);
}

export function getNumProductItems(cart: Cart, productId: string): number {
	return cart
		.filter((item) => item.productId.toString() === productId)
		.reduce((total, item) => total + item.quantity, 0);
}

export function computeTotalCost(cart: Cart): number {
	return cart.reduce((price, item) => price + (item.price * item.quantity), 0);
}

export function numItemsInCart(cart: Cart): number {
	return cart.reduce((total, item) => total + item.quantity, 0)
}

export function getProductImage(productId: string) {
	return productImages[Number(productId)];
}

export function getItemFromCart(cart: Cart, productId: string): CartItem | undefined {
	if (!cart) return;
	return cart.find((value) => value.productId === productId);
}

export function getProduct(products: Array<Product>, productId: string): Product | undefined {
	return products.find((product) => product.id === productId);
}

export type User = {
	id: string,
	firstName: string,
	lastName: string,
	email: string,
};

export type Product = {
	id: string,
	name: string,
	description: string,
	price: number,
	stock: number,
	imageSrc: string,
}

export type CartItem = {
	productId: string;
	quantity: number;
	price: number;
};

export type Cart = Array<CartItem>;

export enum Incrementor {
	Inc,
	Dec,
}

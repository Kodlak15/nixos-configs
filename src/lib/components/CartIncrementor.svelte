<script lang="ts">
	import { updateCart } from "$lib/post";
	import type { Cart, CartItem, Product } from "$lib/types";
	import { Incrementor } from "$lib/types";
	import { getContext } from "svelte";
	import type { Writable } from "svelte/store";

	export let product: Product | undefined;
	export let incrementorId: string;
	export let incrementor: Incrementor;
	export let color: string | undefined;

	export let item: CartItem;

	color = color ? color : "white";

	const cart: Writable<Cart> = getContext("cart");
</script>

{#if cart && product}
	{#if incrementor === Incrementor.Dec}
		<form
			id={incrementorId}
			action={"/shop/" + product.id + "?/removeFromCart"}
			method="POST"
			on:submit={async (event) => await updateCart(event, item)}
		>
			<div
				class="relative border-2 border-transparent border-solid rounded-full hover:cursor-pointer hover:border-black z-50"
			>
				<input
					type="submit"
					value=""
					class="absolute top-0 left-0 w-full h-full hover:cursor-pointer"
				/>
				<svg
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 512 512"
					class="w-6 h-6"
					fill={color}
				>
					<!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path
						d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM184 232l144 0c13.3 0 24 10.7 24 24s-10.7 24-24 24l-144 0c-13.3 0-24-10.7-24-24s10.7-24 24-24z"
					/>
				</svg>
			</div>
		</form>
	{:else}
		<form
			id={incrementorId}
			class={"add-to-cart-" + product.id}
			action={"/shop/" + product.id + "?/addToCart"}
			method="POST"
			on:submit={async (event) => await updateCart(event, item)}
		>
			<div
				class="relative border-2 border-transparent border-solid rounded-full hover:cursor-pointer hover:border-black z-50"
			>
				<input
					type="submit"
					value=""
					class={"absolute top-0 left-0 w-full h-full hover:cursor-pointer"}
				/>
				<svg
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 512 512"
					class={"w-6 h-6"}
					fill={color}
				>
					<!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
					<path
						d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM232 344V280H168c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V168c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H280v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z"
					/>
				</svg>
			</div>
		</form>
	{/if}
{/if}

<script lang="ts">
	import CartPopupItem from "$lib/components/CartPopupItem.svelte";
	import { numItemsInCart, computeTotalCost } from "$lib/utils";
	import type { Cart, Product } from "$lib/types";

	export let cart: Cart | undefined;
	export let products: Array<Product>;
</script>

<div
	class="bg-white absolute top-full mt-2 p-6 border-black border-2 border-solid rounded-md w-full
				z-[99] overflow-auto max-h-96"
	id="cart-popup"
>
	<div class="flex flex-col gap-6">
		{#if !cart || numItemsInCart(cart) === 0}
			<div class="text-2xl text-feldgrau text-center font-bold">
				<h1>Subtotal: $0.00</h1>
			</div>
			<div class="flex justify-center items-center">
				<h1 class="text-feldgrau text-2xl font-bold">No items in cart</h1>
			</div>
		{:else}
			<div
				id="cart-subtotal"
				class="text-2xl text-feldgrau text-center font-bold"
			>
				<h1>Subtotal: ${computeTotalCost(cart)}</h1>
			</div>
			{#each cart ? cart : [] as item}
				{#if item.quantity > 0}
					<!-- TODO figure out how to add items dynamically  -->
					<!-- Should be able to alter the popup by adding items to the cart -->
					<!-- TODO figure out a better way to handle product and cart state -->
					<!-- It would be nice not to have to pass these around to every component -->
					<CartPopupItem {products} {item} {cart} />
				{/if}
			{/each}
		{/if}
	</div>
</div>

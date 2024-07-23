<script lang="ts">
	import CartPopupItem from "$lib/components/CartPopupItem.svelte";
	import { cart, cartSubtotal, numItemsInCart } from "$lib/stores";
</script>

<div
	class="hidden bg-white absolute top-full right-6 mt-2 p-6 border-black border-2 border-solid rounded-md
				z-[99] overflow-auto h-96 min-w-[20rem]"
	id="cart-popup"
>
	<div class="flex flex-col gap-6">
		{#if $numItemsInCart === 0}
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
				<h1>Subtotal: ${$cartSubtotal.toFixed(2)}</h1>
			</div>
			{#each $cart as item}
				{#if item.quantity > 0}
					<CartPopupItem {item} />
				{/if}
			{/each}
		{/if}
	</div>
</div>

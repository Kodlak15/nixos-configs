<script lang="ts">
	import CartPopupItem from "$lib/components/CartPopupItem.svelte";
	import { cart, cartSubtotal, numItemsInCart } from "$lib/stores";
</script>

<div class="flex flex-col justify-center items-center gap-2 p-6">
	<h1 class="text-feldgrau text-2xl font-bold">Under Construction</h1>
</div>

<div class="flex justify-center items-center p-12">
	<div class="flex flex-col gap-12 w-96">
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

<script lang="ts">
	import ShopCard from "$lib/components/ShopCard.svelte";
	import { getItemFromCart } from "$lib/utils";
	import type { Cart, Product } from "$lib/types";
	import { getContext } from "svelte";
	import type { Writable } from "svelte/store";

	const cart: Writable<Cart> = getContext("cart");
	const products: Writable<Array<Product>> = getContext("products");
</script>

<div>
	<section>
		<!-- TODO shop header -->
	</section>
	<section>
		<div class="relative overflow-hidden">
			<div class="relative flex flex-col gap-6 px-6 sm:px-12 pt-12 pb-24 z-10">
				<div class="relative z-20">
					<h1
						class="text-4xl font-bold text-feldgrau font-dancing-script text-center underline"
					>
						Our Products
					</h1>
				</div>
				<div
					class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 justify-items-center gap-6 m-auto max-w-screen-lg"
				>
					{#each $products as product}
						<ShopCard {product} item={getItemFromCart($cart, product.id)} />
					{/each}
					<!-- TODO delete these later, just here to make things look nice while there arent enough products -->
					{#each $products as product}
						<ShopCard {product} item={getItemFromCart($cart, product.id)} />
					{/each}
					{#each $products as product}
						<ShopCard {product} item={getItemFromCart($cart, product.id)} />
					{/each}
				</div>
			</div>
		</div>
	</section>
</div>

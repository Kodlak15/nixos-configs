<script lang="ts">
	import ShopCard from "$lib/components/ShopCard.svelte";
	import { getItemFromCart } from "$lib/utils";
	import type { PageData } from "./$types";

	export let data: PageData;

	const cart = data.cart ? data.cart : [];
</script>

<!-- <div class="px-6 sm:px-12 py-24"> -->
<div class="">
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
					{#each data.products as product}
						<ShopCard
							{product}
							item={getItemFromCart(cart, product.id)}
							{cart}
						/>
					{/each}
					<!-- TODO delete these later, just here to make things look nice while there arent enough products -->
					{#each data.products as product}
						<ShopCard
							{product}
							item={getItemFromCart(cart, product.id)}
							{cart}
						/>
					{/each}
					{#each data.products as product}
						<ShopCard
							{product}
							item={getItemFromCart(cart, product.id)}
							{cart}
						/>
					{/each}
				</div>
			</div>
		</div>
	</section>
</div>

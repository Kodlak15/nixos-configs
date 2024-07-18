<script lang="ts">
	import ShopCard from "$lib/components/ShopCard.svelte";
	import type { PageData } from "./$types";

	import peakImg from "$lib/assets/images/peak.jpg";

	export let data: PageData;

	interface CartItem {
		productId: string;
		quantity: number;
		price: number;
	}

	// TODO this is absolutely atrocious
	// Fix it idiot
	function getProductFromCart(productId: string): CartItem | undefined {
		if (!data.cart) return;

		const item = data.cart.find(
			(value) => value.productId.toString() === productId,
		);

		return item;
	}
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
							productId={product.id}
							name={product.name}
							description={product.description}
							price={product.price}
							item={getProductFromCart(product.id.toString())}
						/>
					{/each}
					<!-- TODO delete these later, just here to make things look nice while there arent enough products -->
					{#each data.products as product}
						<ShopCard
							productId={product.id}
							name={product.name}
							description={product.description}
							price={product.price}
							item={getProductFromCart(product.id.toString())}
						/>
					{/each}
					{#each data.products as product}
						<ShopCard
							productId={product.id}
							name={product.name}
							description={product.description}
							price={product.price}
							item={getProductFromCart(product.id.toString())}
						/>
					{/each}
				</div>
			</div>
		</div>
	</section>
</div>

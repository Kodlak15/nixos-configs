<script lang="ts">
	import ShopCard from "$lib/components/ShopCard.svelte";
	import type { PageData } from "./$types";

	export let data: PageData;
</script>

<div class="px-6 sm:px-12 py-24">
	<section>
		<!-- TODO shop header -->
	</section>
	<section>
		<div class="flex flex-col gap-6">
			<div>
				<h1
					class="text-4xl text-feldgrau font-dancing-script text-center underline"
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
						imageSrc={product.image}
						price={product.price}
					/>
				{/each}
				<!-- TODO delete these later, just here to make things look nice while there arent enough products -->
				{#each data.products as product}
					<ShopCard
						productId={product.id}
						name={product.name}
						description={product.description}
						imageSrc={product.image}
						price={product.price}
					/>
				{/each}
				{#each data.products as product}
					<ShopCard
						productId={product.id}
						name={product.name}
						description={product.description}
						imageSrc={product.image}
						price={product.price}
					/>
				{/each}
			</div>
		</div>
	</section>
</div>

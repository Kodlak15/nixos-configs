<script>
	import ShopCard from "$lib/components/ShopCard.svelte";

	import peppers from "$lib/assets/images/peppers.jpg";
	import trail from "$lib/assets/images/trail.jpg";
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
				<ShopCard imgSrc={peppers} />
				<ShopCard imgSrc={trail} />
				<ShopCard imgSrc={peppers} />
				<ShopCard imgSrc={trail} />
				<ShopCard imgSrc={peppers} />
				<ShopCard imgSrc={trail} />
			</div>
		</div>
	</section>
</div>

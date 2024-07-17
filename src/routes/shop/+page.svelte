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
				<ShopCard imgSrc={peppers} productId="2" />
				<ShopCard imgSrc={trail} productId="3" />
				<ShopCard imgSrc={peppers} productId="4" />
				<ShopCard imgSrc={trail} productId="5" />
				<ShopCard imgSrc={peppers} productId="6" />
				<ShopCard imgSrc={trail} productId="7" />
			</div>
		</div>
	</section>
</div>

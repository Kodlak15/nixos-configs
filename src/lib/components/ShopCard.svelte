<script lang="ts">
	export let imgSrc: string;
</script>

<div class="relative flex flex-col gap-2 rounded-xl overflow-hidden">
	<div class="border-black border-solid border-4 rounded-xl overflow-hidden">
		<img
			src={imgSrc}
			alt=""
			height="350"
			width="350"
			class="w-[350px] h-[350px] object-cover"
		/>
	</div>
	<div class="text-center flex flex-col gap-2">
		<div>
			<h1 class="text-xl">Peppers</h1>
			<h3 class="text-md">$5.99</h3>
		</div>
		<button
			class="bg-black text-white text-xl font-bold p-1 border-black border-solid border-2 rounded-xl"
		>
			Add to cart
		</button>
	</div>
</div>

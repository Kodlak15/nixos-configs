<script lang="ts">
	import { onMount } from "svelte";
	import CartIncrementor from "$lib/components/CartIncrementor.svelte";
	import type { Product, CartItem } from "$lib/types";
	import { Incrementor } from "$lib/types";
	import { getProductImage } from "$lib/utils";

	export let item: CartItem | undefined;
	export let product: Product | undefined;

	onMount(() => {
		if (product) {
			const spans = document.getElementsByClassName(
				"num-cart-items-" + product.id,
			);
			for (let i = 0; i < spans.length; i++) {
				const span = spans[i] as HTMLElement;
				if (item) {
					span.innerText = item.quantity.toString();
				}
			}
		}
	});
</script>

{#if product}
	<div
		class="bg-feldgrau relative flex flex-col rounded-xl overflow-hidden
	hover:shadow-black hover:shadow-md transition duration-200"
	>
		<div
			class="absolute top-0 left-0 border-black border-2 rounded-xl w-full h-full z-10"
		></div>
		<div class="relative rounded-t-xl overflow-hidden">
			<img
				src={getProductImage(product.id)}
				alt="TODO"
				height="350"
				width="350"
				class="w-[350px] h-[350px] object-cover"
			/>
			<div
				id="card-info"
				class="bg-[rgba(0,0,0,0)] hover:bg-[rgba(0,0,0,0.9)] absolute top-0 left-0 flex flex-col
			justify-center items-center gap-2 p-6 w-full h-full transition duration-200 z-20"
			>
				<p class="text-white text-md text-center">
					{product.description}
				</p>
			</div>
		</div>
		<div class="text-center flex flex-col gap-2 p-4 border-black border-t-2">
			<div class="bg-feldgrau font-dancing-script text-white h-full">
				<h1 class="text-2xl font-bold">{product.name}</h1>
				<h2 class="text-lg font-bold">${product.price}</h2>
			</div>
			<div class="flex flex-row justify-center items-center gap-4">
				<!-- TODO allow non-users to interact with the store -->
				{#if item}
					<CartIncrementor
						{product}
						incrementor={Incrementor.Dec}
						incrementorId={"remove-from-cart-" + product.id}
						color="white"
						{item}
					/>
					<span
						class={"num-cart-items-" +
							product.id +
							" font-dancing-script text-white font-bold"}
					>
						{item ? item.quantity : 0}
					</span>
					<CartIncrementor
						{product}
						incrementor={Incrementor.Inc}
						incrementorId={"add-to-cart-" + product.id}
						color="white"
						{item}
					/>
				{/if}
			</div>
		</div>
	</div>
{/if}

<style>
	#card-info > * {
		display: none;
	}

	#card-info:hover > * {
		display: block;
	}
</style>

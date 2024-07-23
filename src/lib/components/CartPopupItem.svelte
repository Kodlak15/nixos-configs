<script lang="ts">
	import CartIncrementor from "$lib/components/CartIncrementor.svelte";
	import type { Product, CartItem } from "$lib/types";
	import { Incrementor } from "$lib/types";
	import { getProductImage, getProduct } from "$lib/utils";
	import { getContext } from "svelte";
	import type { Writable } from "svelte/store";

	export let item: CartItem;

	const products: Writable<Array<Product>> = getContext("products");
</script>

<div class="flex flex-row gap-2 h-40">
	<div
		class="relative flex justify-center items-center basis-[50%] min-h-40 min-w-[125px]"
	>
		<img
			src={getProductImage(item.productId)}
			alt="TODO"
			width="200"
			height="200"
			class="absolute border-2 border-black rounded-md object-cover min-h-full"
		/>
	</div>
	<div class="flex flex-col justify-center gap-2 text-center basis-[50%]">
		<!-- TODO should probably include name as well -->
		<h1>${item.price}</h1>
		<div class="flex flex-row gap-2 justify-center items-center">
			<CartIncrementor
				product={getProduct($products, item.productId)}
				incrementor={Incrementor.Dec}
				color="#475841"
				incrementorId={"remove-from-cart-nav-" + item.productId}
			/>
			<span class={"num-cart-items-" + item.productId}>
				{item.quantity}
			</span>
			<CartIncrementor
				product={getProduct($products, item.productId)}
				incrementor={Incrementor.Inc}
				color="#475841"
				incrementorId={"add-to-cart-nav-" + item.productId}
			/>
		</div>
	</div>
</div>

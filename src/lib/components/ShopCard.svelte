<script lang="ts">
	import CartButton from "$lib/components/CartButton.svelte";

	export let productId: number;
	export let name: string;
	export let description: string;
	export let price: number;
	// export let stock: number; NOTE may need this later

	import peppersImg from "$lib/assets/images/peppers.jpg";
	import trailImg from "$lib/assets/images/trail.jpg";

	const productImages: { [key: number]: string } = {
		3: peppersImg as string,
		4: trailImg as string,
	};

	interface CartItem {
		productId: string;
		quantity: number;
		price: number;
	}

	export let item: CartItem | undefined;
</script>

<div
	class="bg-feldgrau relative flex flex-col rounded-xl overflow-hidden
	hover:shadow-black hover:shadow-md transition duration-200"
>
	<div
		class="absolute top-0 left-0 border-black border-2 rounded-xl w-full h-full z-10"
	></div>
	<div class="relative rounded-t-xl overflow-hidden">
		<img
			src={productImages[productId]}
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
				{description}
			</p>
		</div>
	</div>
	<div class="text-center flex flex-col gap-2 p-4 border-black border-t-2">
		<div class="bg-feldgrau font-dancing-script text-white h-full">
			<h1 class="text-2xl font-bold">{name}</h1>
			<h2 class="text-lg font-bold">${price}</h2>
		</div>
		<div class="flex flex-row justify-center items-center gap-4">
			<CartButton
				productId={Number(productId)}
				operation="sub"
				buttonId={"remove-from-cart-" + productId}
				color="white"
			/>
			<span
				class={"num-cart-items-" +
					productId +
					" font-dancing-script text-white font-bold"}
			>
				{item ? item.quantity : 0}
			</span>
			<CartButton
				productId={Number(productId)}
				operation="add"
				buttonId={"add-to-cart-" + productId}
				color="white"
			/>
		</div>
	</div>
</div>

<style>
	#card-info > * {
		display: none;
	}

	#card-info:hover > * {
		display: block;
	}
</style>

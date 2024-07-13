<script lang="ts">
	export let imgSrc: string;

	// TODO create a struct/interface for shop items
	function addToCart(item: any) {
		const json = localStorage.getItem("cart");
		let cart = json ? JSON.parse(json) : [];

		cart.push(item);
		localStorage.setItem("cart", JSON.stringify(cart));
		updateCart();
	}

	function removeFromCart(item: any) {
		const json = localStorage.getItem("cart");
		let cart = json ? JSON.parse(json) : [];

		const idx = cart.indexOf(item);
		if (idx !== -1) {
			cart.splice(idx, 1);
			localStorage.setItem("cart", JSON.stringify(cart));
		}

		updateCart();
	}

	function itemsInCart(): number {
		const json = localStorage.getItem("cart");
		let cart = json ? JSON.parse(json) : [];
		return cart.length;
	}

	function updateCart() {
		const cartItems = document.getElementById("cart-items");

		if (cartItems) {
			cartItems.innerText = itemsInCart().toString();
		} else {
			console.log("failed to update cart");
		}
	}
</script>

<div
	class="bg-feldgrau relative flex flex-col rounded-xl overflow-hidden
	shadow-sm shadow-feldgrau hover:shadow-black hover:shadow-md transition duration-200"
>
	<div class="relative rounded-t-xl overflow-hidden">
		<img
			src={imgSrc}
			alt=""
			height="350"
			width="350"
			class="w-[350px] h-[350px] object-cover"
		/>
		<div
			id="card-info"
			class="bg-[rgba(0,0,0,0)] hover:bg-[rgba(0,0,0,0.9)] absolute top-0 left-0 flex flex-col
			justify-center items-center gap-2 p-6 w-full h-full transition duration-200"
		>
			<p class="text-white font-dancing-script text-2xl">Product description</p>
		</div>
	</div>
	<div class="text-center flex flex-col gap-2 p-4">
		<div class="bg-feldgrau font-dancing-script text-white h-full">
			<h1 class="text-2xl font-bold">Peppers</h1>
			<h2 class="text-lg font-bold">$5.99</h2>
		</div>
		<div class="flex flex-row justify-center items-center gap-4">
			<button
				class="text-white text-2xl"
				on:click={() => removeFromCart("thing")}
			>
				<svg
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 512 512"
					class="fill-white w-6 h-6"
				>
					<!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
					<path
						d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM184 232H328c13.3 0 24 10.7 24 24s-10.7 24-24 24H184c-13.3 0-24-10.7-24-24s10.7-24 24-24z"
					/>
				</svg>
			</button>
			<!-- <button class="text-white text-2xl" on:click={() => addToCart("thing")}> -->
			<form
				class="text-white text-2xl hover:cursor-pointer"
				method="POST"
				action="/shop"
			>
				<!-- TODO this seems very jank -->
				<input type="text" class="hidden" name="name" value="peppers" />
				<svg
					xmlns="http://www.w3.org/2000/svg"
					viewBox="0 0 512 512"
					class="fill-white w-6 h-6"
				>
					<!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.-->
					<path
						d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM232 344V280H168c-13.3 0-24-10.7-24-24s10.7-24 24-24h64V168c0-13.3 10.7-24 24-24s24 10.7 24 24v64h64c13.3 0 24 10.7 24 24s-10.7 24-24 24H280v64c0 13.3-10.7 24-24 24s-24-10.7-24-24z"
					/>
				</svg>
			</form>
			<!-- </button> -->
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

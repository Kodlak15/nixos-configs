<script lang="ts">
	export let imgSrc: string;

	// TODO create a struct/interface for shop items
	function addToCart(item: any) {
		const json = localStorage.getItem("cart");
		let cart = json ? JSON.parse(json) : [];

		cart.push(item);
		localStorage.setItem("cart", JSON.stringify(cart));
		updateCart(json);
	}

	// function removeFromCart() {}

	function updateCart(json: string | null) {
		let cart = json ? JSON.parse(json) : [];
		const cartItems = document.getElementById("cart-items");

		if (cartItems) {
			cartItems.innerText = cart.length;
		} else {
			console.log("failed to update cart");
		}
	}
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
			on:click={() => addToCart("todo-some-item")}
			class="bg-feldgrau text-white text-xl font-bold p-1 border-black border-solid border-4 rounded-xl"
		>
			<!-- TODO apply count on page reload -->
			Add to cart
		</button>
	</div>
</div>

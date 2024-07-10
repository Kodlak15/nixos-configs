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

<div
	class="
	bg-feldgrau relative flex flex-col gap-2 rounded-xl overflow-hidden
	shadow-sm shadow-feldgrau hover:shadow-black hover:shadow-md transition duration-100
	"
>
	<div class="rounded-t-xl overflow-hidden">
		<img
			src={imgSrc}
			alt=""
			height="350"
			width="350"
			class="w-[350px] h-[350px] object-cover"
		/>
	</div>
	<div class="text-center flex flex-col">
		<div class="bg-feldgrau text-white h-full">
			<h1 class="text-xl font-bold">Peppers</h1>
			<h2 class="text-md font-bold">$5.99</h2>
		</div>
		<button
			on:click={() => addToCart("todo-some-item")}
			class="bg-feldgrau text-white text-xl font-bold p-2"
		>
			<!-- TODO apply count on page reload -->
			Add to cart
		</button>
	</div>
</div>

<script lang="ts">
	async function updateCartWidget(quantity: number) {
		const itemsInCart = document.getElementById("items-in-cart");
		if (!itemsInCart) {
			console.log("Unable to update UI: Missing items-in-cart widget");
			return;
		}

		itemsInCart.innerText = quantity.toString();
	}

	async function addToCart(event: SubmitEvent) {
		const form = document.getElementById(
			"add-to-cart-" + productId,
		) as HTMLFormElement;

		event.preventDefault();
		const formData = new FormData(form);

		try {
			const response = await fetch(form.action, {
				method: "POST",
				body: formData,
			});

			if (response.ok) {
				const result = await response.json();
				const quantity = JSON.parse(result.data)[2];
				updateCartWidget(quantity);
			} else {
				console.log("Failed to add item to cart");
			}
		} catch (error) {
			console.error("Error:", error);
		}
	}

	async function removeFromCart(event: SubmitEvent) {
		const form = document.getElementById(
			"remove-from-cart-" + productId,
		) as HTMLFormElement;

		event.preventDefault();
		const formData = new FormData(form);

		try {
			const response = await fetch(form.action, {
				method: "POST",
				body: formData,
			});

			if (response.ok) {
				const result = await response.json();
				const quantity = JSON.parse(result.data)[2];
				updateCartWidget(quantity);
			} else {
				console.log("Failed to remove item from cart");
			}
		} catch (error) {
			console.error("Error:", error);
		}
	}

	export let productId: number;
	export let name: string;
	export let description: string;
	export let price: number;
	// export let stock: number; NOTE may need this later
	export let imageSrc: string; // NOTE not sure that this will work (see hacky solution below)
	// ^^^ May need to use a CDN in practice if loading images from the database ^^^

	import peppersImg from "$lib/assets/images/peppers.jpg";
	import trailImg from "$lib/assets/images/trail.jpg";

	const productImages: { [key: number]: string } = {
		3: peppersImg as string,
		4: trailImg as string,
	};
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
			<form
				id={"remove-from-cart-" + productId}
				action={"/shop/" + productId + "?/removeFromCart"}
				method="POST"
				on:submit={async (event) => await removeFromCart(event)}
			>
				<div
					class="relative border-2 border-transparent border-solid rounded-full hover:cursor-pointer hover:border-black z-50"
				>
					<input
						type="submit"
						value=""
						class="absolute top-0 left-0 w-full h-full hover:cursor-pointer"
					/>
					<svg
						xmlns="http://www.w3.org/2000/svg"
						viewBox="0 0 512 512"
						class="fill-white w-6 h-6"
					>
						<!--!Font Awesome Free 6.6.0 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path
							d="M256 512A256 256 0 1 0 256 0a256 256 0 1 0 0 512zM184 232l144 0c13.3 0 24 10.7 24 24s-10.7 24-24 24l-144 0c-13.3 0-24-10.7-24-24s10.7-24 24-24z"
						/>
					</svg>
				</div>
			</form>
			<!-- TODO replace the {2} with the product id -->
			<form
				id={"add-to-cart-" + productId}
				action={"/shop/" + productId + "?/addToCart"}
				method="POST"
				on:submit={async (event) => await addToCart(event)}
			>
				<div
					class="relative border-2 border-transparent border-solid rounded-full hover:cursor-pointer hover:border-black z-50"
				>
					<input
						type="submit"
						value=""
						class="absolute top-0 left-0 w-full h-full hover:cursor-pointer"
					/>
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
				</div>
			</form>
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
